---
title: "Forking Visual Studio Code"
date: 2018-09-10
draft: false
slug: forking-vs-code
---


I have been using Visual Studio Code for a few weeks now. I like how fast it is and its extensibility model. Its extension points are well designed. I am currently using it for javascript, flutter and markdown. I have been able to find extension for most things I wanted to do.

I also [forked vs code](https://github.com/fertrig/vscode/commits/ds-view-prototype) to test a new editor interface. The idea with the fork is to provide a code-behind experience, where each file has a textual and visual representation. Both representations would have to be kept in sync as the user makes changes to either.

Swapping the editor is not part of their extension model, so if I go with this approach I would have to propose some major changes to their extensibility API.

While diving into the source code of VS Code I got familiar with TypeScript. I think TypeScript is the way to go for code bases that need to scale. Its interface and type model is just enough to give more sanity to Javascript. In larger code bases, it will make refactoring safer. 

I regret not using it sooner.