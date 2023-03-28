---
title: "Sending and Receiving Email using Mandrill"
date: 2014-03-03
draft: false
slug: send-receive-emails-mandrill
---

This post will show you how your NodeJS app can send and receive emails using Mandrill. It will show you how to setup the emails you send so that when your users reply to those emails, your application can process those replies.

The trick to receive emails is to send the initial email with a unique reply-to email address. That way, when the user replies to the email, your app will use that unique email address to process the message.

For the examples in this post, the reply-to email address will look like *reply-123@replies.sampleapp.com*, where *123* is the unique id of some object in your app. We use *reply-* in the email address because that lets us setup a route in Mandrill that matches email addresses that starts with *reply-* followed by some id. The mandrill documentation tells you how to setup that kind of route, see section Adding Routes in [Mandrill's Inbound Email Processing Overview](http://help.mandrill.com/entries/21699367-Inbound-Email-Processing-Overview).

### Sending
We only need to set a few things before we send the email. Below we have the function that will set the values we need. It takes the name of the user that is sending the email, a list of users that should get the email, a subject for the email, it also gets some object and a message for that object.

```Javascript
function sendEmail(fromName, users, subject, someObject, message) {
    
    // the sender email will look like 
    // 'John Doe &lt;notification@sampleapp.com&gt;'
    var fromEmail = 'notification@sampleapp.com';

    // by forming this address this way, when users reply, 
    // they will see "Reply to Comment" 
    // and not necessesarily the weird looking email address 
    // (that, of course, will depend on the user's email client)
    var replyToEmail = 
        "Reply to Comment &lt;r-" + 
        someObject._id + 
        "@replies.sampleapp.com&gt;";

    // it's always a good idea to add a tag to similar messages, 
    // that will let you filter them out easily 
    // in mandrill's admin portal
    var tags = [ "sample-messages" ];

    var to = users.map(function(user) {
        return { 
            "email": user.email,
            "name": user.firstName + " " + user.lastName
        };
    });

    mandrill_wrapper.send(
        fromName, 
        fromEmail, 
        to, 
        replyToEmail, 
        subject, 
        message, 
        tags);
}
```

We created a *mandril_wrapper* object which encapsulates most of the actual mandrill call, since this sample app is so simple, we don't use most of the fields in the mandrill api, the wrapper hides all of that away. Here's the wrapper code:

```Javascript
// In mandrill_wrapper.js
var mandrill = require('mandrill-api/mandrill'),
	mandrill_client = new mandrill.Mandrill(process.env.MANDRILL_APIKEY),
	self = {};

exports.send = function(fromName, fromEmail, to, replyToEmail, subject, text, tags) {
	var message = {
		"html": null,
		"text": text,
		"subject": subject,
		"from_email": fromEmail,
		"from_name": fromName,
		"to": to,
		"headers": {
			"Reply-To": replyToEmail
		},
		"important": false,
		"track_opens": null,
		"track_clicks": null,
		"auto_text": null,
		"auto_html": null,
		"inline_css": null,
		"url_strip_qs": null,
		"preserve_recipients": null,
		"bcc_address": null,
		"tracking_domain": null,
		"signing_domain": null,
		"merge": true,
		"global_merge_vars": [],
		"merge_vars": [],
		"tags": tags,
		"google_analytics_domains": [],
		"google_analytics_campaign": null,
		"metadata": null,
		"recipient_metadata": [],
		"attachments": [],
		"images": []
	};
	var async = false;
	var ip_pool = null;
	var send_at = null;
	
	mandrill_client.messages.send({"message": message, "async": async, "ip_pool": ip_pool, "send_at": send_at}, function(result) {
		console.log('Mandrill API called.');
		console.log(result);
	}, function(e) {
		console.error('A mandrill error occurred: ' + e.name + ' - ' + e.message);
	});
};
```

###Receiving
Now that users have received their emails, they can reply to them. You do have to make sure your Mandrill setup is correct, see section Set up your domain in [Mandrill's Inbound Email Processing Overview](http://help.mandrill.com/entries/21699367-Inbound-Email-Processing-Overview). Once your setup is correct, Mandrill will get your user's replies and post them to our sample app using a webhook. Since a webhook posts using an HTTP POST, we can just add a route for it. If you are using express, the route that handles the post from Mandrill (with the replies contents) looks like the function below.

```Javascript
// the route is /replies because that is the webhook 
// we setup in mandrill
app.post('/replies', function(req, res) {

	// mandrill will send the replies in the request body 
	// as mandrill_events
	var replies = JSON.parse(req.body.mandrill_events);  

	// here we are using async to process the replies, 
	// note that mandrill could 
	// send us a batch of replies, 
	// so we need to be able to process multiple replies
	async.each(  
		replies, 
		function(reply, callback) {
			// according to mandrill's docs, 
			// incoming emails will have the event of 'inbound'
			if (reply.event === 'inbound') { 
				// we'll explain what to do here below
				processReply(reply, callback);  
			} else {
				callback();
			}
		}, 
		function(err) {
			// once we are done processing the replies, 
			// we should send mandrill 
			// the 200 status code, which means OK
			res.send(200);  
		}
	);
});
```

Now that we have a reply ready to be processed, we can use the reply's *from_email* to find the user that replied, then we'll use the reply's email to parse the object id that should get the message, and we'll even use the reply's timestamp for our object.

```Javascript
function processReply(reply, processCallback) {
	async.parallel({
		user: function(callback) {
			User.findOne(
				{ email: reply.msg.from_email }, 
				callback);
		},
		someObject: function(callback) {
			// here we parse the id out of the email, 
			// which was in the reply-to field when we 
			// sent the original message
			var objectId = parseObjectId(reply.msg.email);
			SomeObject.findById(objectId, callback);
		}
	}, 
	function(err, results) {
		if (err) {
			handleErrors(err, processCallback);
		} else {
			Message.create({
				// we'll explain this function below
				content: removeQuotedText(reply.msg.text), 
				createdById: results.user._id,
				// mandrill returns a UTC unix timestamp, 
				// we just need to multiply it by 1000 to 
				// make it a regular date time
				timestamp: new Date(reply.ts*1000),  
				objectId: results.someObject._id
			}, processCallback);
		}
	});
}
```

The last final detail would be to truncate the quoted text in the email. When you reply to an email the original message is still part of the reply, depending on your requirements you may want to trim the original message. There isn't a solution that will remove the quoted text 100% of the time. It is difficult because you have to parse text and email clients difer on the characters they use to mark quoted text.

For this sample app, we are just going to trim everything under the original notification email *notification@sampleapp.com*, which will only work if the email client includes the original email in the reply (gmail does it).

```Javascript
function removeQuotedText(text) {
	var delimeter = 'notification@sampleapp.com';

	// escaping the dot in .com, so it doesn't affect our regex pattern below
	delimeter.replace('.','\\.');  

	// this matches from the beginning of the email, 
	// multiple lines, until the line 
	// the has the delimeter, lines under the delimeter 
	// (including the delimeter line) won't match
	var pattern = '.*(?=^.*' + delimeter + '.*$)';  

	// we are using XRegExp
	var regex = xregexp(pattern, 'ims');  
	
	var delimeterFound = xregexp.test(text, regex);

	if (delimeterFound) {
		var match = xregexp.exec(text, regex);
		return trimNewLines(match[0]);
	} else {
		return trimNewLines(text);
	}
}

// email clients usually add extra white lines after the reply, 
// this function removes empty 
// new lines before and after the passed in text
function trimNewLines(text) {
	return text.replace(/^\s+|\s+$/g, '');
}
```

This blog showed how to setup the emails you send so when the user replies, those emails can be processed by your application.
  