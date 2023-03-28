---
title: "Chicken Sexing Doesn’t Work in Software"
date: 2017-10-27
draft: false
slug: chicken-sexing-doesnt-work-in-software
---

![](/images/chicken-sexing-software.png)

Estimating how long a software project will take is like trying to guess the sex of a day-old chicken. They are both very difficult. Only highly trained [chicken sexers can reliably guess the sex of a chick](http://www.businessinsider.com/the-incredible-intuition-of-professional-chicken-sexers-2012-3). Even if you ask them how they know, they will tell you they “just do,” and that they can’t communicate exactly how it is they are so certain, and the way they have learned is by working side-by-side with someone that has mastered this esoteric skill.

Expert chicken sexers are very valuable to large poultry operations. Knowing the sex of a chicken as soon as possible saves a lot of resources. Male chicks get placed in a different program than female chicks. Some male chicks are kept for food production. Most female chicks are destined to lay eggs.

In the software world, there might be some expert software engineers that could tell us with precision how long a software project will take. However, I have never met one. I think those software engineers, like expert chicken sexers, are rare indeed.. Most poultry farms, like most software teams, need to do what they can with what they have.

Let’s say one of us, without any chicken sexing experience, has to distinguish the sex of a group of one thousand chickens. What would be the most efficient and effective way of making this distinction? Nature gives us a 50/50 chance of getting the sex right. Just by dividing the chicks into two groups we could say that the first group are females and the second group are males, in which case we would be correct 50% of the time. If we try to actually guess the sex of each chicken, it would not only take a long time but our accuracy may also drop to below 50%.

If your team follows an agile process, like Scrum or Kanban, something similar happens when estimating stories. It is very difficult for your team to tell you how long a story will take. The team spends valuable time estimating the size of each story and most of the time [their estimates are wrong](https://www.targetprocess.com/blog/2011/04/5-reasons-why-you-should-stop-estimating-user-stories/). This process is neither efficient nor effective.

I have found that a better approach is for your team to look at each story and just answer one question: “is this story too big? If so, we should split it.” This question yields a yes/no type answer. This model gives the team two simple choices, a binary choice, which is far easier to answer than a multiple choice answer like estimating how long a story will take.

After your team has answered this question for all the stories and has split up any that are too big, you will end up with stories that are roughly the same size. While some of them will be smaller, some of them will be bigger, generally they will all be about the same size That’s ok too, we just don’t want any that are too big. Once you have stories sized in this manner, you count them, and once you have the story count you let the team work on them. After the first week or the first month, you will see how many stories the team has completed. Only then will you know how many stories the team can complete in a week or month. *This is your initial benchmark.* As time goes on, you will have more data about your team’s performance, and eventually you will have an average number of stories per week that the team can complete. As your team removes impediments, the average number of stories per week should increase, which will increase the speed at which you deliver software.

Once you have an average number of stories per period of time, you can start to reliably release plan using this vital metric. Your team will continue to answer the question “is this story too big? If so, we should split it.” That question makes sure that all of your stories are roughly the same size which [makes your planning much simpler and reliable](http://jpattonassociates.com/the_shrinking_story/).

How do you know if a story is too big? That depends on your team and on your system. For some teams “too big” maybe something that takes more than a couple of days to code and test, for others it may be something that takes more than a couple of hours. You have to experiment and see what works for you.

Most software teams, including our team at [Dropsource](http://dropsource.com/), develop software in a very complex context. The requirements, the code, the tests are all complex. Our users and our teams are made up of complex individuals. In the face of complexity we need simple methods and solutions. Sizing stories to be the same size is one of those simple methods that avoid the complexity of estimating stories.

At Dropsource, we don’t have any expert chicken sexers (that I know of), which is why this simple method of sizing and counting stories has worked out very well for us.
  