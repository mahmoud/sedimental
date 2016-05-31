---
title: Benching Microbenchmarks
tags:
  - python
  - code
  - statistics
  - work
---

In under one week, [*Statistics for Software*][s4s] blew past
[*10 Myths for Enterprise Python*][10moep] and became the most visited
post in the history of the PayPal Engineering blog. It even earned
[a Japanese translation][s4s_jp] already. Taken as an indicator of
increased interest in software quality, this really floats all boats.

There were enough emails and comments to warrant one quick followup in
particular.

[s4s]: https://www.paypal-engineering.com/2016/04/11/statistics-for-software/
[10moep]: https://www.paypal-engineering.com/2014/12/10/10-myths-of-enterprise-python/
[s4s_jp]: http://postd.cc/statistics-for-software/

# Statistics for benchmarks

<img width="25%" align="right" src="/uploads/illo/tachometer_med.png"
title="Too many developers are building software without these.">

The saying in software goes that there are lies, damned lies, and
software benchmarks.

Yes, quantiles, histograms, and other fundamentals covered in
*Statistics for Software* can certainly be applied to improve
benchmarking. One of the timely inspirations for the post was a major
network appliance vendor selling 5-figure machines, without providing
or even measuring latency in quantiles. Just throughput-over-time
averages.

We gave them a [Jupyter][jupyter] notebook that drove test traffic. A
second notebook provided the numbers they should have measured. We've
amalgamated elements of both into
[a single notebook on PayPal's Github][perf_nb]. Two weeks later they
had a new firmware build that sped up our typical traffic's 99th
percentile by two orders of magnitude. Google, Amazon, and their other
customers will probably get the fixes in a few weeks, too. Meanwhile,
we're still waiting on our gourmet cheese basket.

[jupyter]: http://jupyter.org/
[perf_nb]: https://github.com/paypal/support/blob/master/notebooks/benchmarking_servers_before_and_after.ipynb

Even though our benchmarks were simple, they were specific to the use
case, and utilized robust statistics. But even the most robust
statistics won't solve the real problem: systematic overapplication of
one or two microbenchmarks across all use cases. We must move forward,
to a more modern view.

# Performance as a feature

Any framework or application branding itself as performant *must*
include measurement instrumentation as an active interface. One cannot
simply benchmark once and claim performance forever.[^1] Applications
vary widely. There is no performance-critical situation where
measurement is not also necessary. Instead, we see a glut of
microframeworks, throwing out even the most obvious features in the
name of speed.

Speed is not a built-in property. Yes, Formula 1 race cars are fast
and yes, F1 designers are very focused on weight reduction. But they
are not shaving off grams to set weight records. The F1 engineers are
making room for
[more safety, metrics, and alerting][f1_telemetry]. Once upon a time,
this was not possible, but technology has come a long way since last
century. So it goes with software.

[f1_telemetry]: https://www.metasphere.co.uk/telemetry-data-journey-f1/

To honestly claim performance on a featuresheet, a modern framework
*must* provide a fast, reliable, and resource-conscious measurement
subsystem, as well as a clear API for accessing the
measurements. These are good uses of your server cycles. PayPal's
internal Python framework does all of this on top of [SuPPort][support],
[faststat][faststat], and [lithoxyl][lithoxyl].

[support]: https://github.com/paypal/support
[faststat]: https://github.com/doublereedkurt/faststat
[lithoxyl]: https://github.com/mahmoud/lithoxyl

<img width="30%" align="right" src="/uploads/illo/ping_pong_med.png"
title="Enough with the games. They're noisy and not even that fun.">

# Benching the microbenchmark

Microbenchmarks were already showing signs of fatigue. Strike one was
the frequent lack of reproducibility. Strike two came when software
authors began gaming the system, changing what was written to beat the
benchmark. Now, microbenchmarks have officially struck out. Echos and
ping-pongs are worth less than their namesakes. Today, it is more
important that a framework provides an idiomatic facility for
measuring each individual system's actual performance.

[^1]: I'm not naming names. Yet. You can
      [follow me on Twitter][mhashemi_tw] in case that changes.

[mhashemi_tw]: https://twitter.com/mhashemi
