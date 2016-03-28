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
yielding four measures, each representing a progression that adds
to the data description:

1. Mean - The central tendency of the data
2. Variance - The tightness of the grouping around the mean
3. Skewness - The symmetry or bias toward one end of the scale
4. Kurtosis - The amount of data in "the wings" of the set

As a group these are known as shape descriptors of a distribution, and
tell a much more complete story about the data. But, while they have
their applications, we're not going to delve into the math, because
these measures all suffer from the same key problem as the mean.

Moment-based measures are not *robust*, meaning that they
simultaneously:

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

# Quantifying for success

If you've ever taken a standardized test, or paid attention during tax
season, you're already familiar with quantiles. Quantiles are points
which subdivide the space into equal parts. In practice we usually
speak about quartiles (4-parts) and percentiles (100-parts). Most
nontechnical areas focus in on the *median* as a robust central
indicator.

However, experienced engineers are happy to know the median, the data
doesn't get interesting until we get into the extremes. For
performance and reliability, that means the 95th, 98th, 99th, and
99.9th percentiles.

The challenge with quantiles is efficient computation. The traditional
way to calculate the median, for instance, is to choose the middle
value or the average of the two middle values from a sorted set of
*all* the data. Considering all the data may be the only way to
calculate exact quantiles, but in practice, every application has its
error tolerances. We can estimate quantiles much more efficiently.

## Reservoir sampling

Scaled down version of the data, like a thumbnail. Streaming, but also
works with populations of unknown size, so it fits perfectly with
applications like response latency tracking.

Not pre-selecting the quantile points also enables better probability
density estimation with techniques like KDE.

Histograms are massively useful for engineering applications

One of the major advantages of moment-based measures like the mean and
variance is the ease with they can be combined together. There is no
such operation for a median. The median of medians is not the median
of the whole, and the mean of the medians is right out.

Teservoir sampling readds this power of data set combination. With the
count of the associated data, we can create a weighted dataset
representative of both. This mergeability of a streaming summary is
what makes it "distributed".

## Shortcomings and practical improvements

Reservoir sampling has its shortcomings. In particular, like a
thumbnail it lacks resolution if you're interesting in very specific
areas. Good implementations of reservoir sampling will already track
the maximum and minimum values, but for engineers interested in the
edges, we recommend keeping an increased set of the exact
outliers. For example, for critical paths, track the 10 highest
response times observed in the last hour.

P2?

# Next steps

Statistics is a huge field, and engineering offers a huge range of
applications. There are a lot of places to go from here, and we wanted
to offer some running starts for the areas we feel are natural
extensions to the fundamentals above.

## More advanced statistics

* Cardinality, HLL, Sketches
* EWMA (nuanced, requires interpretation)
* Tracking correlations
* Applying predictive modeling, like regressions and fitting
  distributions can help you assess whether you are collecting
  sufficient information, or if you're missing some metrics.
* Not all data makes sense as a time series. It may be easy to
  implement certain algorithms over time series streams, but be
  careful about shoehorning.

## Instrumentation

We focused a lot on statistical fundamentals, but how do we generate
relevant datasets in the first place? Our answer is through structured
instrumentation of our components. With the right hooks in place the
data is already there when we need it, whether we're dropping
everything to debug or when we have a spare cycle to improve
performance.

One of the many advantages to investing in instrumentation early is
that you get a sense for the overhead of data collection. Reliability
and features are far more important in the enterprise than
performance. With a low enough barrier to entry,

# Vocabulary

Whether you're evaluating yourself after reading this article, or
interviewing a candidate with statistics on their resume, this handy
list can help check one's ability to discuss statistics fundamentals
as applied to complex systems.


# Also mention

* Probability distribution: A mapping of a given value to the
  probability of seeing that value in the data.
* Just looking at summary statistics isn't enough.

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
* "Big data" is not a necessary step toward understanding big
  systems. In fact, in practice, data size often inversely correlates
  with information density and utility.
