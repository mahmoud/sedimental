---
title: CalVer 26.0
entry_root: calver_26
tags:
  - python
  - versioning
  - code
draft: true
---

A decade ago, a little bit of history was made. I didn't realize it, but a colleague made a great point, one of those real mind-changing points that seem too obvious to admit same-day. But, the next day, [calver.org][calver] was born.

At the time my team maintained the Python infrastructure for eBay and PayPal, and we were stuck deciding whether we were really ready for a "major" 1.0 release. *[Semantic Versioning](https://semver.org/)* was the only game in town and "major" means "big", right?!

Thankfully, a wiser colleague mentioned: Ubuntu and Twisted don't struggle with version number debates. They slap a date on it and keep shipping. In fact, their date-based versions were even better because you always knew where it stood, in terms of updatedness *and* support.

The only problem is that no one really knew about it. Somehow, this problem solving versioning alternative, arguably as old as history itself, had gone nameless for millenia, conspiring to make me feel foolish in an office meeting. Never again!

[calver]: https://calver.org

# Ten years of adoption

Fast forward 10 years, we've seen CalVer adopted by Apple, Nvidia, JetBrains, and countless others. The site may have more inbound links than any other project of mine. [Apple][apple_cv] made the biggest jump, at WWDC 2025: 

- iOS went from 18 to 26
- macOS from 15 to 26
- watchOS from 11 to 26
- and visionOS from 2 to 26

All landing on one, consistent number like a car's model year. I still remember the texts from the Venn diagram fanbase of my friends who love Apple and reasonable versioning. No such texts from when [NVIDIA][nvidia_cv] announced calendar versions across the GPU Operator, RAPIDS, and its monthly NGC containers, but still very cool.

Open source, too: Home Assistant, pip, CockroachDB, and yt-dlp all ship on dates, with plenty more on [the users page][users]. The conversation even reached the language core; [PEP 2026][pep2026] proposed versioning CPython as `3.YY`, and it almost happened, too. And it's never too late, time marches on!

[apple_cv]: https://calver.org/#apple
[nvidia_cv]: https://calver.org/#nvidia
[users]: https://calver.org/users.html
[pep2026]: https://peps.python.org/pep-2026/

# Fixing the notation

But I don't think I got every detail right from day 1. That's the main motivator for CalVer 26. It's high time to start righting a couple idiosyncratic token design choices, starting with some additions:

<img align="right" width="30%" src="/uploads/illo/caltree_med.png">


| Meaning | Before 26.0 | 26.0 |
|---|---|---|
| Full year | `YYYY` | `YYYY` |
| Short year (6, 16) | `YY` | `YY` |
| Zero-padded year (06, 16) | `0Y` | `0Y` |
| **Short month (1 ... 12)** | **`MM`** | **`M`** |
| Zero-padded month (01 ... 12) | `0M` | `0M` |
| **Short week (1 ... 52)** | **`WW`** | **`W`** |
| Zero-padded week (01 ... 52) | `0W` | `0W` |
| **Short day (1 ... 31)** | **`DD`** | **`D`** |
| Zero-padded day (01 ... 31) | `0D` | `0D` |

## Seeing double

First, the doubled letters. From the first version (16.6), `MM` and `DD` meant the *unpadded* month and day, which reads backwards to anyone who knows date formats (ISO 8601's `YYYY-MM-DD`, Java, moment.js, day.js), as some community members [correctly pointed out][hn2020]. I was ready to flip them, until I checked what people actually use: most projects with a `YY.MM.MICRO` badge (conda, Twisted, Ansible's tooling) don't pad, and bumpver, bump-my-version, and more than a dozen other tools implement the old meaning. 

So, it's too late to flip MM's meaning. Instead, 26.0 deprecates it and offers a more explicit and hopefully clearer option: `M` is the short month, `0M` the padded one, and `MM` is a technically-retired synonym for `M`. In case you're wondering, the explicit `0M` was me being overinspired by Ubuntu's approach, perhaps: `6.06` pads its month but not its year, and `YY.0M` says exactly that. 

### To pad or not to pad

I think it's worth a detour into why padding is even a thing anyways.

It's become important now that new ecosystems have emerged that enforced SemVer formatting semantics, and I wanted clear guidance about on the spec site. [SemVer][semver] forbids leading zeros outright, so Cargo rejects `26.04.0` and Go modules reject `v26.04.0`. Even Python's packaging spec [normalizes leading zeros away][pep440_norm], so you can tag `2026.08.19` if you want, but PyPI will still show `2026.8.19`. NVIDIA's GPU Operator docs [put it this way][nvidia_lifecycle]: "Zero padding is omitted for month to be still compatible with semantic versioning."

CalVer was always intended to drop in where SemVer was used. So 26.0 recommends unpadded (`YYYY.M.D`) as a sane "pure" default for software libraries. But libraries are not the only objects of versioning schemes.

The exception is a version that becomes a filename, an image tag, or an object-store key that gets listed lexically. There, padding keeps `26.10` sorted after `26.09`, which is why Ubuntu, NixOS, and NVIDIA's own NGC containers pad. More evidence of teams [designing their versions](https://sedimental.org/designing_a_version.html). We love to see it. 

Our [FAQ][padding_cv] has a longer discussion of the padding issue, as well.

[pep440_norm]: https://packaging.python.org/en/latest/specifications/version-specifiers/#integer-normalization
[semver]: https://semver.org/
[nvidia_lifecycle]: https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/life-cycle-policy.html
[padding_cv]: https://calver.org/#to-pad-or-not-to-pad

## Optional segments

There was never any rule against them, but 26.0 makes optional trailing segments more explicit with square brackets. Now, yt-dlp's scheme can finally be written down: `YYYY.0M.0D[.MICRO]`.

For the CalVer badges I could find on GitHub, they all stay valid for now. I've got a [note on the deprecated spellings][scheme_cv] and a new copy-paste [badge section][badges_cv] for new ones.

[hn2020]: https://news.ycombinator.com/item?id=21967879
[scheme_cv]: https://calver.org/#scheme
[badges_cv]: https://calver.org/#badges

# What else is new?

It's always a great time to add more citations to the site.

  * A [spec changelog][changelog_cv]; the spec now versions itself: 16.6, 19.7, 26.0.
  * A [FAQ][faq_cv]: breaking changes, same-day releases, and padding.
  * [The users page][users], rebuilt by category, with past users of note (schemes change; that's fine) and tooling.
  * Case studies: Apple and NVIDIA in, yt-dlp replacing youtube-dl.

Much of the thinking behind these changes happened in the [GitHub issue tracker][issues] over the years, and 19 or so issues close with this release. That's where ideas for CalVer should go, so by all means, open an issue, and we'll get it sorted! In due time, of course.

[changelog_cv]: https://calver.org/#spec-changelog
[faq_cv]: https://calver.org/#frequently-asked-questions
[issues]: https://github.com/mahmoud/calver/issues

[MH: name contributors to thank? hugovk, issue reporters, translators.]

Thanks to all, but especially Mark, Glyph, Hugo, issue reporters, translators, and maintainers) for making the most timely versioning system, CalVer, a timeless classic.

# See also

- [2016 announcement][calver_2016] 
- [Designing a version][dav] 
- [My Yap on Why CalVer beats Semver](https://yap.so/p/2RMbM6RMBb4)

[calver_2016]: /calver.html
[dav]: /designing_a_version.html
