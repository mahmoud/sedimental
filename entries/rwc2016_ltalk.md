---
title: RWC 2016 Lightning Talk
publish_date: 12:20pm January 7th, 2016
tags:
  - code
  - work
  - python
  - security
---

> _Today I had the pleasure of talking on stage for ~2 minutes at the
> [Real World Crypto 2016 conference][rwc2016] in Stanford, CA. This
> is a pseudotranscript of that lightning talk._

[rwc2016]: http://www.realworldcrypto.com/

I'm Mahmoud Hashemi and I work as a Lead Developer at PayPal. I mostly
focus on [Python frameworks and software infrastructure][pp_blog], but
for the last couple years I've been working on Application
Security. In fact, my first assignment, back in late 2012, was reverse
engineering and reimplementing Max Levchin's Certicom elliptic curve
integration, in Python.

These days I work on PayPal's comprehensive key management (and HSM
integration) system. Suffice to say, we work a lot with encryption and
secure sockets. _Also_ suffice to say, we're a bit nervous about
[OpenSSL][openssl]. With all the news lately we've started design
discussions with regard to how we can hedge our OpenSSL bets.

In Python, this translates to a [DBAPI 2.0][dbapi2]-like abstraction
layer to enable swapping out security implementations. Like many
[ORMs][orm] (e.g., [SQLAlchemy][sqla]), but for security. Honestly,
there are usually better/more reasons to switch SSL implementations
than relational databases. We want an API that allows us to leverage
other great SSL implementations, including OpenSSL-derivatives like
[LibreSSL][libressl], as well as other implementations like
[WolfSSL][wolfssl]. PayPal already has a diverse SSL ecosystem, with
multiple versions of OpenSSL and tons of JVM-based implementations,
making it a great testbed ecosystem.

To achieve this we're hoping to have some productive discussions with
the experienced engineers and cryptographers that attend RWC. It's
still very early days, and there are a lot of corner cases, so we'll
need all the advice we can get. Help us invest in the algorithms, not
the implementations. Design for replaceability, to avoid having
17-year-old libraries serving today's security-hungry Internet. You
can contact me at [github.com/mahmoud][gh],
[twitter.com/mhashemi][tw], or [mahmoud@paypal.com][pp].

[pp_blog]: https://medium.com/paypal-tech/search?q=python
[openssl]: https://www.openssl.org/
[libressl]: http://www.libressl.org/
[dbapi2]: https://www.python.org/dev/peps/pep-0249/
[orm]: https://en.wikipedia.org/wiki/Object-relational_mapping
[sqla]: http://www.sqlalchemy.org/
[wolfssl]: https://www.wolfssl.com/wolfSSL/Home.html
[gh]: https://github.com/mhamoud
[tw]: https://twitter.com/mhashemi
[pp]: mailto:mahmoud@paypal.com

<img title="A partially obfuscated view from the stage of RWC2016"
width="70%" src="/uploads/rwc2016_stage.jpg">

_A partially obfuscated view from the stage of RWC2016_
