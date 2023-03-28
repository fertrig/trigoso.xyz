---
title: "Event Sourcing at Dropsource"
date: 2018-02-01
draft: false
slug: event-sourcing-at-dropsource
---

![](/images/event-sourcing-at-dropsource.png)

In a [previous blog post](/content/posts/2017/event-sourcing-vs-traditional-architectures.md) I mentioned that Dropsource implements the [Event Sourcing pattern](https://martinfowler.com/eaaDev/EventSourcing.html). In this post, I will describe the advantages of implementing Event Sourcing and the lessons we have learned.

In Dropsource, every time you make a change to your project you are generating events or facts—I like the term “fact” over “event”, because the term “event” is overloaded in the software industry. Dropsource stores this stream of facts and uses it to create a model of what your mobile app looks like. The Dropsource Editor and the Dropsource Builder use this model to render views and to generate code respectively.

Let’s look at an example. Let’s say you create a ‘home’ page, drop a label onto the page and then drop a text field on the same page. These three facts are what we use to generate a model for your app, and every new fact makes a small change to your app’s model. The table below lists those three facts and their corresponding changes to the model.

| Fact #  | Fact Data  | Model  |
|---|---|---|
| 1  | <ul><li>fact type: page created</li><li>name: home</li></ul>  | <ul><li>Home (page)</li></ul>   |
| 2  | <ul><li>fact type: element created</li><li>parent: home</li><li>element type: label</li></ul>   | <ul><li>Home (page)<ul><li>Label 1 (label)</li></ul></li></ul>   |
| 3  | <ul><li>fact type: element created</li><li>parent: home</li><li>element type: text field</li></ul>  | <ul><li>Home (page)<ul><li>Label 1 (label)</li><li>Text Field 1 (text field)</li></ul></li></ul>  |


Let’s say you make a few more changes. You even delete some things. Let’s see how your model evolves.


| Fact #  | Fact Data  | Model  |
|---|---|---|
| 4  | <ul><li>fact type: element created</li><li>parent: home</li><li>element type: button</li></ul>  | <ul><li>Home (page)<ul><li>Label 1 (label)</li><li>Text Field 1 (text field)</li><li>Button 1 (button)</li></ul></li></ul>   |
| 5  | <ul><li>fact type: element deleted</li><li>element: Text Field 1</li></ul>   | <ul><li>Home (page)<ul><li>Label 1 (label)</li><li>Button 1 (button)</li></ul></li></ul>    |
| 6  | <ul><li>fact type: element created</li><li>parent: home</li><li>element type: switch</li></ul>  | <ul><li>Home (page)<ul><li>Label 1 (label)</li><li>Button 1 (button)</li><li>Switch 1 (switch)</li></ul></li></ul>  |


You can see how every fact makes a small change to the model. These incremental changes are a fundamental concept of Event Sourcing. It is a very simple idea that can scale very well. At Dropsource, we have projects with thousands of facts that generate very large models.

There are many benefits we have experienced from our Event Sourcing implementation. I think the most important one is that we have future-proofed our platform. As we implement new features that require significant changes to our current data structures, the only thing we have to do is change the code that generates the models. We don’t have to do risky data migrations or massive database schema changes.

Our implementation has enabled our company to be more experimental. We can try new features or change existing functionality while keeping the engineering risk low. That is a huge win.

There is one thing about our Event Sourcing implementation that you don’t see very often—we generate most of our facts on the client-side. Our Editor is what generates these facts; most Event Sourcing implementations generate facts on the server-side. The advantage of generating facts on the client-side is that we can keep the user experience very fluid. As you make changes to your project, the Editor doesn’t interrupt you while saving. The Editor will create a fact, apply the change to the model so you can see it on the screen, and then submit the fact to our back-end services. Our saving process is simple, we don’t have to generate deltas of models or submit the entire state of your app to our back-end services. We only need to submit the new fact you generated.

Features like Versioning (coming soon) are very easy to implement with Event Sourcing. We just have to version your project at a specific point in the stream of facts. When we implement Undo/Redo (I know, I can’t wait either) we focus on reversing the previous fact, which makes the solution small for every undo/redo operation. We can also build team collaboration features in the future, as one user makes changes we send the new facts to a different user.

There are many other advantages we have experienced, the ones I described are just a few worth highlighting. If you’re interested in learning more about our experience, leave a comment below.

The main lesson learned is that caching is critical. As our users develop more sophisticated apps, the size of the fact stream grows. Replaying the entire history of facts can be resource and time consuming. We cache the models heavily on our backend services, which keeps the response times low. If you have a large project in Dropsource, you may have noticed that the load time of the Editor increases. We will reduce those load times by sending your cached models to your browser.

An application like Dropsource is complex, thus we need technologies that will reduce the complexity so we can focus on the value we provide to our users. We think Event Sourcing is one of the best decisions we have made as a company.