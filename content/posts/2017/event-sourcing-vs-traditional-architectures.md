---
title: "Event Sourcing Versus Traditional Architectures"
date: 2017-07-11
draft: false
slug: event-sourcing-vs-traditional-architectures
---

_Implementing Event Sourcing in your application offers significant advantages over traditional architectures._

As you add new features to your application you may have realized that your initial assumptions about your data model are not adequate. You end up doing expensive data migrations and changes to your software. Your business, or worse, your customers, end up paying the price because changes take longer than expected. How can your application be more agile over time?

Before I answer that question let me take you back to a time before computers, when records had to be kept on paper. Imagine a company that had to keep track of their employees information: address, dependents, payroll, tax forms, and phone numbers, and so much more for each and every employee, current and past. To track all of this information, the company kept records for each employee, and to record changes they would follow these steps:

* Get a new piece of paper
* Date it
* Write down what happened
* Append it to the end of the employee record

What are some of the characteristics of storing data this way?

* It is very simple
* Changes are incremental and immutable; they didn’t go back and change things that happened a year ago
* Records could grow very large: only constrained by the size of the warehouse in which records were stored
* Time is built-in; managers could go back and review the state of the employee at different points in time
* It is future-proof; adding more concepts and relationships to the employee model did not force modifications to previous records
  
Let’s introduce the early computers to this system. They had limited memory and they weren’t very fast. Because of these limitations computer programmers could not store data in a similar way. They had to store only the current state of the employee. To do so they needed to pre-emptively design the entities and relationships of an employee record.

For example, they had to pre-allocate a place to store the phone number of an employee. When the employee changed his phone number, the system would override the original value and replace it with the new one. The system would totally forget what the employee’s previous phone numbers were, as if it never existed.

As we now know, this design isn’t future proof. Not too long ago people only had one phone number, their home landline. Fast forward a few years and people started having multiple numbers; an office number, perhaps a home office number, their home number, pager numbers, and cell phone numbers. All of this changed the initial design of how the data is stored and made things quite difficult.

I argue that it is still difficult because we are still storing data this way. This is true of relational databases and document-oriented databases. If you ever had to migrate data you know how risky that can be.

Fortunately, it is 2017 and some things have changed. Storage is very cheap and abundant, and computers are super fast. Event sourcing systems resemble the early information systems, and recent technological improvements have enabled more software teams to implement Event Sourcing for their applications. You can read Martin Fowler’s take on Event Sourcing [here](https://martinfowler.com/eaaDev/EventSourcing.html).

Following the phone number example from above, in an Event Sourcing system the change in phone numbers would be represented by two facts: one fact stating that a phone number was added and another fact stating that the phone number was changed. If the employee needed to add another phone (mobile, office, etc.), that addition would be represented by yet another fact.

Every fact records the time at which it was created. Once you have this type of system you can do some powerful things:

* Snapshot of your data at any given point in time which enables versioning
* See changes since a given point in time
* Facts can be reversed which is great for undo/redo functionality
* It is future proof; new facts don’t affect older facts

Since your data is stored as a series of facts, your application is the one responsible for replaying the facts and generating the models your business logic and UI need.

Here, at Dropsource, we have implemented Event Sourcing to manage the data our users generate when they work on their projects. If you are a Dropsource user, then every time you drop an element on the canvas or every time you add a new action, you are generating facts. We use those facts to build a model of your mobile application, which we then use to generate the source code.

There is an increase in the adoption of Event Sourcing. There are people trying to develop frameworks around the Event Sourcing concepts, like [Event Store](https://eventstore.org/) and [Datomic](http://www.datomic.com/). Event Sourcing and CQRS (a similar pattern) have been part of the Domain-Driven Design [approach](https://www.infoq.com/news/2016/06/ddd-software-development) for quite some time. The fast adoption of Kafka has also made Event Sourcing more popular for [complex applications](https://www.confluent.io/blog/event-sourcing-cqrs-stream-processing-apache-kafka-whats-connection/).
