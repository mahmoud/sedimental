---
title: Simple Statistics for Systems
subtile: Easier development and maintenance through reintroduction
---

Software development begins as a quest for capability, doing what
could not be done before. But as soon as that *what* is achieved, the
engineer must ask *how*. In enterprise software, the most frequently
asked questions are, "How fast?" and more importantly, "How reliable?"

These software questions cannot be answered, or even properly
articulated, without statistics.

Most developers can't tell you much about statistics. It simply
doesn't come up. Because between coding and maintenance, who has the
time? Even a small amount of the right statistics can greatly lessen
the load of maintenance, and take a lot of the guesswork out of future
development. Everyone needs a reintroduction to statistics after a few
years of real work. Even if you studied statistics in school,
something about real work, real data, and real questions have a way of
making you wonder if it was really you who passed those statistics
exams.

Looking at the behavior of the system, we have to be critical,
unbiased investigators. We instrument the system, turning it into a
stream that generates data, such as timing information like
durations. Then, we analyze this stream using statistical methods. The
starting point for these statistical methods is to use descriptive
statistics that treat these numerical values as random variables.

* Collecting metadata about how the application is used and how the
  application is performing.

Collecting data is all about balance. As any Internet-connected
individual knows, too much data and both you and your system are
overwhelmed. Too little data and, at best, you might as well have not
bothered. At worst you'll make an uninformed decision that'll take you
down a bad path.

So what tools does the engineer have for responsible collection? Well,
like metadata volume, there really is no limit to the dimensions or
techniques. That said, you can get quite far with the fundamentals, so
let's get started covering the groundwork.

# Harnessing momentum

Measures based on statistical moments may sound fancy or even
sentimental, but virtually everyone can compute an arithmetic mean,
also known as "the average". The mean is nice to calculate and
seemingly nice to reason about, but there's a reason this post doesn't
end here. In fact, the many dilemmas of the mean are the reason this
post exists.

The mean should almost never be of interest to an engineer. The mean
is simply not a trustworthy representative of most engineering data.

The mean is the first statistical moment. There four moments in all,
yielding four measures, representing a progression that goes further in
describing the data:

* Mean - The central tendency of the data
* Variance - The tightness of the grouping around the mean
* Skewness - The symmetry or bias toward one end of the scale
* Kurtosis - The amount of data in "the wings" of the set

As a group these are known as shape descriptors of a distribution, and
tell a much more complete story about the data. However, before you go
getting overwhelmed by the definitions and calculations, these shape
parameters still suffer from the same key problem as the mean.

Moments They are
not *robust* measures, meaning that they simultaneously:

  * Are skewed by outliers
  * Dilute the importance of those outliers

This is especially problematic, as outliers occur everywhere in
real-world systems, and they often represent the most critical data
for a troubleshooting engineer.

<!--
Going further than that, many engineering problems involve multimodal
distributions. Consider response times from an HTTP service:

* Successful requests (200s) take a "normal" amount of time
* Client failures (400s) complete quickly, as little work can be done with invalid requests.
* Server errors (500s) can either be very quick (backend down) or very slow (timeouts)

Here it's obvious that have several curves overlaid, with at least 3
or 4 peaks. Maintaining a single mean and variance is really not doing
the data justice.

-->

# Quantifying success

If you've ever taken a standardized test, or paid attention during tax
season, you're already familiar with quantiles. In practice we usually
speak about percentiles, especially the most famous 50th percentile,
aka the *median*.

* Reservoir sampling

## Reservoir sampling

Scaled down version of the data, like a thumbnail. Distributable. Not
pre-selecting the quantile points also enables better probability
density estimation with techniques like KDE.

# Also mention

* Robustness (trimming?)
* Distributability
* Histograms (CDF, PDF)
* Probability distribution: A mapping of a given value to the
  probability of seeing that value in the data.
* Just looking at summary statistics isn't enough.
* Don't take averages of medians

Out of scope, but mention in next steps:

* Cardinality (HLL)
* Count min sketch
* EWMA is nuanced, takes interpretation
* Applying predictive modeling, like regressions and fitting
  distributions can help you assess whether you are collecting
  sufficient information, or if you're missing some metrics.
* Not all data makes sense as a time series. It may be easy to
  implement certain algorithms over time series streams, but be
  careful about shoehorning.

This post focused on streaming, numeric, descriptive, non-parametric
statistical measures. There are many other types of data. Categorical
data that is discrete/incomparable. Time series data which occurs at
specific intervals.

* If you can establish what a typical day looks like for a given
  service, you can pretty much set it and forget it. Most
  organizations make do with simply overlaying charts with the last
  week, but this requires constant manual interpretation, doesn't
  compose well for longer-term trend analysis, and really doesn't work
  when the previous week isn't representative (i.e., had an outage or
  a spike).
