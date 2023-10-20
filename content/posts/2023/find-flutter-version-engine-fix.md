---
title: "How to Find the Flutter Version of a Flutter Engine Fix"
date: 2023-10-04
slug: find-flutter-version-engine-fix
---

Many times there is a fix in the flutter/engine repo which I care about. I usually have the commit for the fix but what I need is the released Flutter SDK version that includes the flutter/engine fix. However, finding the Flutter SDK version for a flutter/engine commit is complicated because flutter/engine commits are not part of the flutter/flutter repo.

_You can follow the instructions [Finding the Framework commit that contains Engine commit X](https://github.com/flutter/flutter/wiki/Where's-my-commit%3F#finding-the-framework-commit-that-contains-engine-commit-x). Those instructions are good. However, you need to know the PR. If you only have the commit, or if you want to do it via git commands, then follow the steps below. In any case, you will need to find the released flutter sdk version, for that see the section below: [Find Flutter SDK version](#find-flutter-sdk-version)._

At a high level, here is how flutter/engine commits can be tracked to released Flutter SDK versions:

A flutter/engine commit is contained by some flutter/engine tag. This tag has its own flutter/engine commit hash. This flutter/engine commit will be referenced in the commit message of a flutter/flutter commit. This flutter/flutter commit is contained by some flutter/flutter tag. However, not all flutter/flutter tags are released. Thus, you then have to use this flutter/flutter tag to find the Flutter SDK released version that contains the tag.

Below are the git commands you can use to find all the commits and tags you need.

I'm going to use a concrete example. The flutter/engine commit I cared about was `d1712b2ff3f0273c224583aa0c151228f4b0c73c`. Thus, given that flutter/engine commit...

### Find flutter/engine tag commit
First, see the commit details using `git show`:
```sh
git show d1712b2ff3f0273c224583aa0c151228f4b0c73c
```

Then, find the first tag containing the commit:
```sh
git describe --contains d1712b2ff3f0273c224583aa0c151228f4b0c73c
```
The output could be something like `3.13.0-6.0.pre~15`. Which gives you the first tag containing the commit and how far back your commit is. In this example the commit is 15 commits behind the commit with the tag.

Now you need to find the flutter/engine tag's commit which is the revision the flutter/flutter repo will reference.
```sh
git show 3.13.0-6.0.pre
```
Which will give you the commit details for the tag. In this case, the flutter/engine commit for the tag is `39d60be72ffb`.  

Copy the first few characters of the commit. The first 8 or 12 characters should be enough to find it in the flutter repo logs. Don't use the whole hash length because the flutter repo logs only reference the commit using the first 10 or 12 characters.

### Find flutter/flutter tag
Now, we go to the flutter/flutter repo to find the commit that references the flutter/engine commit.
```sh
# in flutter/flutter repo
git log | grep -C 10 -E "Roll Flutter Engine from [a-zA-Z0-9]+ to 39d60be72ffb"
```
This should output the commit in flutter/flutter repo that references the flutter/engine commit for the tag. Make sure to replace your commit in the regex above.

In this case, the flutter/flutter commit is `33d174d797efd85839730d9173eac3884f5768d5`. With that commit you can find the first flutter/flutter tag that contains that commit.
```sh
git describe --contains 33d174d797efd85839730d9173eac3884f5768d5
```
Which should give you a flutter/flutter tag like `3.13.0-6.0.pre`.

### Find Flutter SDK version
Now you can go the the [flutter release](https://docs.flutter.dev/release/archive?tab=macos) page and find the released version that contains the tag above in the beta channel. In this case, the beta channel had these versions:

- 3.14.0-0.1.pre
- 3.13.0-0.4.pre
- 3.13.0-0.3.pre

Since version `3.13.0-6.0.pre` is in between versions `3.13.0-0.4.pre` and `3.14.0-0.1.pre`. Then the flutter/engine fix you were looking for was released with Flutter SDK version `3.14.0-0.1.pre`.

You need to look at the beta releases, and not stable ones, because the stable releases get hot fixed with point versions. Thus `3.13.1` is a hot fix on top of `3.13.0` thus it `3.13.0-6.0.pre` is not included in `3.13.1`.

It's a lot. This needs to be automated.