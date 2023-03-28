---
title: "My Monarch Journey"
date: 2023-02-15
draft: false
slug: monarch-journey
---

I have been working on [Monarch](https://monarchapp.io/) for the past couple of years.
It has been exciting, challenging and frustrating. It has also
been rewarding and uncomfortable. I had to learn and do things I hadn't done
before. 

It has been good.

Here is a list of what I have been up to.

### Programming 
Monarch is developer tool for Flutter developers, thus I had to get pretty good
at Flutter and Dart. I love Dart. It's a great language. I also had to get familiar
with the tooling of Dart and Flutter. I got into some obscure areas of the ecosystem
like mirrors, reflection, vm_service, analysis server, code generation, grpc, etc.

Since Monarch needs to run on multiple operating systems I had to learn Swift programming 
on macOS. I have been using macs for a while so that wasn't too bad. However, I also 
had to run Monarch on Windows. I hadn't used Windows in many years so I felt some friction
there. I also had to re-learn C++ programming. I hadn't done C++ since school. C++ is hard, 
and it is also so fast and so cool. Then I had to port Monarch to Linux. I had never 
done development on Linux so I had to learn the Linux ecosystem, and also learn GTK.

### Automation
Monarch needs to be built on macOS, Windows and Linux and also against many Flutter versions.
The automation that manage those builds is powerful: it automatically runs a new build when 
a new Flutter version
comes out, it runs builds on multiple platforms at the same time, it builds and deploys 
Monarch binaries, it manages releases, etc.

Every time I improve the Monarch automation my life gets easier.

### Developer Experience
Monarch is a developer tool. Thus, my priority has been the developer experience.

- Monarch has a command-line interface (CLI) so developers can easily run it and upgrade it.
- It also has a UI since it is a UI tool. 
- It is fully open source. 
- There is no lock-in. 
- It has minimal dependencies.
- It gets out of the way. 
- It doesn't require sign-ups.
- It's API is really small, which makes it very easy to learn. 
- It is simple yet powerful.

### Architecture
I spend a lot of time thinking about software architectures. I like seeing architectures 
from different perspectives: static dependencies, runtime design, deployment design, even 
directory structure design is important.

The [Monarch Architecture](https://github.com/Dropsource/monarch/wiki/Monarch-Architecture) 
document describes the Monarch architecture in more detail.

### Messaging and Strategy
I work on the Monarch messaging and strategy as well. I have been writing a lot during the 
past two years, which I enjoy. Here is some of my writing:

- Monarch [website](https://monarchapp.io/)
- Monarch [docs](https://monarchapp.io/docs/introduction)
- Monarch [release notes](https://monarchapp.io/blog)
- Monarch [intro video](https://youtu.be/yblMOMfbZno)
- Monarch [wiki](https://github.com/Dropsource/monarch/wiki)
- [Interacting with people on Reddit](https://www.reddit.com/r/FlutterDev/search/?q=monarch) has been pretty cool as well.

### Flutter, Flutter Engine and Dart deep dives
Monarch uses some features of Flutter, Flutter Engine and Dart that most of the community doesn't use.
Thus, it is hard to find answers to issues I run into. Many times I have had to do 
deep dives throughout the Flutter, Flutter Engine and Dart code bases. It is hard, and 
often tedious, but it is part of the job.

You can find the issues I have authored here: [link](https://github.com/flutter/flutter/issues?q=author%3Afertrig).


### The Future

> No matter where you are in life, there is always more journey ahead.  
> 
> --Nelson Mandela

My Monarch journey goes on.
