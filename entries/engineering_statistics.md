---
title: Engineering Statistics
---

Looking at the behavior of the system, we have to be critical,
unbiased investigators. We generate data, especially timing
information like durations, and we analyze it using statistical
methods. The starting point for these statistical methods is to use
descriptive statistics that treat these numerical values like duration
as random variables.

Maybe you took statistics, maybe you didn't. Probably not many
remember a lot of details. Turns out for engineering you don't need to
know much. Actually, I've seen many teams who don't pay attention to
statistics at all. But inevitably there comes a time when there are
questions to be answered, and you don't want to be like those
teams. Not only don't they know the answers, but they don't even know
what terms to put the questions in.

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

Also mention:

* Robustness
* Distributability
* Histograms (CDF, PDF)

Out of scope, but mention in next steps:

* Cardinality (HLL)
* Count min sketch
* EWMA is nuanced, takes interpretation

This post focused on streaming, numeric, descriptive, non-parametric
statistical measures. There are many other types of data. Categorical
data that is discrete/incomparable. Time series data which occurs at
specific intervals.
