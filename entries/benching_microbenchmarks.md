---
title: Benchmarking Microbenchmarks
---

In under one week, Statistics for Software blew past 10 Myths for
Enterprise Python and became the most visited post in the history of
the PayPal Engineering blog. It even already has a Japanese
translation. I take this as an indicator of increased focus on
software quality, which makes me quite happy.

There were enough emails and comments to warrant one quick followup in
particular.

# Benchmarks

<img width="40%" align="right" src="/uploads/illo/tachometer_med.png"
title="Faster is better always of course.">

The saying in software goes that there are lies, damned lies, and
software benchmarks.

Yes, quantiles, histograms, and other fundamentals covered in
Statistics for Software can certainly be applied to benchmarking. But
that won't fix the problem. The goal was to move toward a more modern
view.

Any framework branding itself as performant *must* include measurement
instrumentation as an active interface. One cannot simply benchmark
once and claim performance.[^1] To claim performance means to claim it is
suitable for performance-critical situations. There is no
performance-critical situation where measurement is not also
necessary. Instead, we see a glut of microframeworks, swearing off
features in the name of speed.

Speed cannot be a built-in property of a framework. Yes, Formula 1
race cars are very focused on weight reduction. But it's not shaving
off grams to set speed or weight records. There's real work to
do. Engineers are making room for
[more safety, metrics, and alerting][f1_telemetry]. Once upon a time,
this was not the case. Technology has come a long way since last
century.

[f1_telemetry]: https://www.metasphere.co.uk/telemetry-data-journey-f1/

To honestly claim performance on a featuresheet, a modern framework
*must* provide a fast, reliable, and resource-conscious measurement
subsystem, as well as a clear API for accessing the
measurements. These are good uses of your server cycles. PayPal's
internal framework does all of this on top of [SuPPort][support],
[faststat][faststat], and [lithoxyl][lithoxyl].

[support]: https://github.com/paypal/support
[faststat]: https://github.com/doublereedkurt/faststat
[lithoxyl]: https://github.com/mahmoud/lithoxyl

Microbenchmarks were already teetering with a reputation for lack of
reproducibility and intentional mismeasurement. Now, they have
officially struck out. In an age when it is more important to provide
a useful, idiomatic facility for measuring every individual system's
real performance, echos and ping-pongs are worth less than their
namesakes.

[^1]: I'm not naming names yet, but you can follow me on Twitter in
      case that changes.
