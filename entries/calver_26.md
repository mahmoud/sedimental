---
title: "CalVer 26.0: Calendar Versioning, ten years on"
entry_root: calver_26
tags:
  - python
  - versioning
  - code
draft: true
---

It's been 10 years since my team at PayPal went from 0 to 16, and today I'm pleased to announce we're going to 26. CalVer 26, that is. And what a milestone it is.

A decade ago, my team maintained the Python infrastructure for eBay and PayPal, and when it came to releasing this unified framework we were stuck deciding whether we were really ready for a 1.0 major release. "Semantic Versioning" was the only game in town and 1.0 is a big deal! Oh how young we were.

Thankfully, a wiser team member mentioned: Ubuntu and Twisted don't struggle with version number debates. They slap a date on it and kept shipping. In fact, their date-based versions were even better because you always knew where it stood, in terms of updatedness AND support.

Well, I slept on it and woke up the next day, fully off my crusade to 1.0 and now marching straight to 16.0, preaching the gospel of date-based versioning along the way. The only problem is that no one really knew about it. Somehow, this versioning scheme as old as time itself, had gone this long without a name. Not long after, CalVer was born, along with https://calver.org

And in the last 10 years, we've seen it adopted by Apple, Nvidia, and countless others. I think calver.org may have more inbound links than any other project of mine.

But I don't think I got every detail right from day 1. That's the main motivator for CalVer 26. It's high time to right a couple idiosyncratic token design choices, summarized here:

(insert table)

New ecosystems have emerged that enforced SemVer formatting semantics that bear making more clear guidance about on the calver.org site. CalVer was always intended to drop in where SemVer was used. These new recommendations help default CalVer stay indistinguishable to parsers, but more practical calendar-based semantics.

Plus, it's a great time to add more citations to the site. Thanks to all for making the most timely versioning system the timeless classic that it always deserved to be.

