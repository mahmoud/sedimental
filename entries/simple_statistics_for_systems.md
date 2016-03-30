---
title: Simple Statistics for Systems
subtile: Easier development and maintenance through reintroduction
---

Software development begins as a quest for capability, doing what
could not be done before. But as soon as that *what* is achieved, the
engineer is left to face the *how*. In enterprise software, the most
frequently asked questions are, "How fast?" and more importantly, "How
reliable?"

Questions about software performance cannot be answered, or even
appropriately articulated, without statistics.

And yet, most developers can't tell you much about statistics. Much
like math, statistics simply don't come up for typical
project. Between coding and maintenance, who has the time?

Engineers must make the time. A few core practices go a long way in
generating meaningful systems analysis. And a few common malpractices
will set a project way back. This brief refresher on key statistical
fundaments will have you lightening maintenance load and taking a lot
of guesswork out of future development.

<!--
Everyone needs a reintroduction to statistics after a few years of
real work. Even if you studied statistics in school, real work, real
data, and real questions have a way of making you wonder if it was
really you who passed those statistics exams.
-->

# Data collection and statistical convention

Looking at the behavior of the system, we have to be critical,
unbiased investigators. We instrument the system, turning it into a
stream that generates data, such as function execution times, and
usage information, like request lengths and response codes.

With these data collection streams in place, it's time to reach into
the statistical toolbox. The unbiased starting point is to treat these
numerical values as random variables and use descriptive
statistics. While that may sound obvious, remember that much of
statistics is dedicated to inferring and modeling future
outcomes. Knowing that "descriptive" statistics is the technical
opposite of "inferential" statistics drastically narrows down future
searches.

Collecting data is all about balance. Too little data and, at best,
you might as well have not bothered. At worst, you make an uninformed
decision that takes you down with it. Then again, too much data can
also result in downtime, and even if you keep an eye on memory
consumption, you need to consider the time consumption of sifting
through data excess. "Big data" is not a necessary step toward
understanding big systems. We want dense, balanced data.

So what tools does the engineer have for balanced collection? Much
like metadata volume and dimensions, the techniques go on and on. That
said, you can get quite far with the fundamentals, so let's start
covering the groundwork with familiar territory.

# Harnessing momentum

The concept of a statistical moment may sound advanced or even a
little like a niche hashtag, but virtually everyone can compute an
arithmetic mean, also known as the average. Our everyday average is
what's known as the first statistical moment. The mean is nice to
calculate and can be quite englightening, but there's a reason this
post doesn't end here.

The mean is just one of four statistical moments. There are four
moments in all, yielding four measures, each representing a
progression that adds to the data description:

1. Mean - The central tendency of the data
2. Variance - The tightness of the grouping around the mean
3. Skewness - The symmetry or bias toward one end of the scale
4. Kurtosis - The amount of data in "the wings" of the set

As a group these are known as shape descriptors of a distribution, and
tell a much more complete story about the data. Each successive
measure adds less practical information than the last, which is why
skewness and kurtosis are often left out. But for the practical
engineer, we can go one step further.

The mean, variance, skewness, and kurtosis are almost never the right
tools for a performance-minded engineer. Moment-based measures are not
trustworthy representatives of most engineering data.

Moment-based measures are not *robust*. Non-robust statistics
simultaneously:

* Prone to skew by outliers
* Dilute the importance of those outliers

This makes moment-based statistics especially problematic, as outliers
occur everywhere in real-world systems. In practice, outliers often
represent the most critical data for a troubleshooting engineer. The
last thing we want is a fragile measure like the mean, dampening our
statistical fun.

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

Reservoir sampling readds this power of data set combination. With the
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

We focused here on descriptive, non-parametric statistics, most of
which was numeric. This creates several obvious areas to expand into:

**Non-parametric statistics** gave us quantiles, but also offers so
much more. Generally, non-parametric is used to describe any
statistical construct that does not presume a specific probability
distribution, e.g. normal or binomial. This means it offers the most
broadly-applicable tools in the descriptive toolbox. This includes
everything from the familiar histogram to the

**Categorical statistics** contrast with numerical statistics in that
the data is not mathematically measurable. Categorical data can be
big, such as IPs and phone numbers, or small, like user languages. The
key metrics in this area are around counts, or cardinality. PayPal's
Python services use HyperLogLog and Count-Min sketches for
distributable streaming cardinality measurements. While reservoir
sampling is much simpler, and can be used for categorical data as
well, HLL and CMS offer increased space efficiency, and more
importantly: proven error bounds. After grasping reservoir sampling,
but before delving into advanced cardinaltiy structures, you may want
to have a look at [boltons ThresholdCounter][btc], the heavy hitters
counting used extensively in PayPal's Python services.

[btc]: http://boltons.readthedocs.org/en/latest/cacheutils.html#threshold-bounded-counting

**Inferential statistics** contrast with descriptive statistics in
that the goal is to develop models and predict future
performance. Applying predictive modeling, like regressions and
fitting distributions, can help you assess whether you are collecting
sufficient data, or if you're missing some metrics. If you can
establish a reliable model for your service and hook it into modeling
and alerting, you'll have reached SRE nirvana. In the meantime, many
teams make do with simply overlaying charts with the last week, but
this requires constant manual interpretation, doesn't compose well for
longer-term trend analysis, and really doesn't work when the previous
week isn't representative (i.e., had an outage or a spike).

**Parametric statistics** contrast with non-parametric statistics in
that the data is presumed to follow a given probability
distribution. If you've established a model using inferential
statistics, and that model can be put in terms of standard
distributions, you've given yourself a powerful set of abstractions
with which to reason about your system. We could do a whole article on
the probability distributions we expect from different parts of our
Python backend services (hint: expect a lot of
[fish][poisson]). Teasing apart the curves inherent in your system is
quite a feat, but don't drift too far from the real data, and as with
any extensive modeling exercise heed the cautionary song of the black
swan.

**Multivariate statistics** allow you to analyze multiple output
variables at a time. It's easy to go overboard with multiple
dimensions, as there's always an extra dimension if you look for it.
Nevertheless, a simple, practical exploration of correlations can give
you a better sense of your system, as well as inform you as to
redundant data collection.

**Multimodal statistics** abound in real world data, where multiple
distributions are embedded in a single set. Consider response times
from an HTTP service:

* Successful requests (200s) take a "normal" amount of time
* Client failures (400s) complete quickly, as little work can be done with invalid requests.
* Server errors (500s) can either be very quick (backend down) or very slow (timeouts)

Here we can assume that we have several curves overlaid, with at least
3 or 4 peaks. Maintaining a single summary is really not doing the
data justice. Statistics really struggles with multimodal
scenarios. There are times when you will want to discover and track
datasets separately, and others when it makes more sense to bite the
bullet and leave the data mixed.

**Time-series statistics** transforms the data stream by
contextualizing it with a single, near-universal dimension: time. Data
is collected at continuous, fixed-length intervals. At PayPal time
series are used all over, from per-minute transaction and error rates
to the Python team's homegrown Pandas $PYPL stock price analysis. Not
all data makes sense as a time series. It may be easy to implement
certain algorithms over time series streams, but be careful about
shoehorning. Time-bucketing leaves a massive imprint on the data,
leading to fewer ways to safely combine samples and more shadows of
misleading correlations.

**Moving statistics** are another area that can be combined with time
to create a powerful metric. For instance, the exponentially-weighted
moving average (EWMA), famously used by UNIX to represent load:

```TODO: output```

This output packs a lot of information into a small space, and is very
cheap to track, but it takes some knowledge and understanding to
interpret correctly. EWMA is simultaneously familiar and
nuanced. Unless it has an immediate consumer or your application is
very resource constrained, there are better metrics. It's fun to
consider whether you want time series-style discete buckets or the
continuous window of a moving statistic. For instance, do you want the
counts for yesterday, or the past 24 hours? Previous hour or the last
60 minutes? PayPal Python services keep a few moving metrics, but
generally use a lot more time series. TODO

**Survival analysis** is used to analyze the lifetimes of system
components, and must make an appearance in any engineering article
about reliability. Invaluable for simulations and post-mortem
investigations, when the software industry gets to a point where it
leverages this field as much as the hardware industry, the technology
world will be a better place.

## Instrumentation

We focused a lot on statistical fundamentals, but how do we generate
relevant datasets in the first place? Our answer is through structured
instrumentation of our components. With the right hooks in place the
data is already there when we need it, whether we're dropping
everything to debug or when we have a spare cycle to improve
performance.

One of the many advantages to investing in instrumentation early is
that you get a sense for the overhead of data collection. Reliability
and features far outweigh performance in the enterprise space. Many
critical services could be up to twice as fast without
instrumentation, but removing this aspect would render them
unmaintainable. Good work takes cycles, and for most services, metrics
collection around critical paths is second only to the features
themselves.

Much of PayPal's Python services' robustness can be credited to a
reliable remote logging infrastructure, combined with a robust,
unobtrusive instrumentation framework.

# Vocabulary

Whether you're evaluating yourself after reading this article, or
interviewing a candidate with statistics on their resume, this handy
list can help check one's ability to discuss statistics fundamentals
as applied to complex systems.


# Also mention

* Probability distribution: A mapping of a given value to the
  probability of seeing that value in the data.
