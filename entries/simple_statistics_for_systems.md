---
title: Straightforward Software Statistics
subtile: Easier development and maintenance through reintroduction
---

Software development begins as a quest for capability, doing what
could not be done before. Once that *what* is achieved, the engineer
is left with the *how*. In enterprise software, the most frequently
asked questions are, "How fast?" and more importantly, "How reliable?"

Questions about software performance cannot be answered, or even
appropriately articulated, without statistics.

Yet most developers can't tell you much about statistics. Much like
math, statistics simply don't come up for typical project. Between
coding the new and maintaining the old, who has the time?

Engineers must make the time. It's time to broach the topic, learn
what works, and take the guesswork out of software. A few core
practices go a long way in generating meaningful systems analysis. And
a few common mistakes set projects way back. This guide aims to both
lighten software maintenance and speed up future development through
answers made possible by the right kinds of applied statistics.

<!--
Everyone needs a reintroduction to statistics after a few years of
real work. Even if you studied statistics in school, real work, real
data, and real questions have a way of making you wonder if it was
really you who passed those statistics exams.
-->

[TOC]

# Collection and convention

To begin, we consider a target component we want to measure and
improve. At PayPal this is often one of our hundreds of HTTP server
applications. If a developer were to look at our internal frameworks,
they would find hundreds of critical paths that have been instrumented
to generate streams of measurements: function execution times, request
lengths, and response codes, for instance.

We discuss more about instrumentation below, but for now we assume
these data collection streams are in place and focus on numerical
measurements like durations. The correct starting point minimizes
bias. We assume the least, treating our measurements as values of
random variables. So opens the wide world of descriptive statistics, a
whole area devoted to describing the behavior of randomness. While
this may sound obvious, remember that much of statistics is dedicated
to modeling and inferring future outcomes. Knowing that "descriptive"
statistics is the technical opposite of "inferential" statistics
drastically narrows down future searches.

Collecting measurements is all about balance. Too little data and you
might as well have not bothered, in the best case. Worst case, you
make an uninformed decision that takes your service down with it. Then
again, too much data can also result in downtime, and even if you keep
an eye on memory consumption, you need to consider the resources
required to through excess data. "Big data" looms large, but it is not
a necessary step toward understanding big systems. We want dense,
balanced data.

So what tools does the engineer have for balanced collection? When it
comes to metadata, there is never a shortage of volume, dimensions, or
techniques. To avoid getting lost, we focus on descriptive summary
statistics that can be collected with minimal overhead. Now that we
know the direction, let's start out from familiar territory.

# Moments of truth
<!-- moment of truth. moment of inertia. spur of the moment. -->

The concept of a statistical moment may not sound familiar, but
virtually everyone uses them, including you. By age 10, most students
can compute an average, otherwise known as the arithmetic mean. Our
everyday mean is known to the informed few as the first statistical
moment. The mean is nice to calculate and can be quite enlightening,
but there's a reason this post doesn't end here.

The mean is just one of four statistical moments. There are four
moments in all, yielding four measures, each representing a
progression that adds up to a standard data description:

1. Mean - The central tendency of the data
2. Variance - The tightness of the grouping around the mean
3. Skewness - The symmetry or bias toward one end of the scale
4. Kurtosis - The amount of data in "the wings" of the set

As a group these are known as shape descriptors of a distribution, and
tell a much more complete story about the data. Each successive
measure adds less practical information than the last, which is why
skewness and kurtosis are often left out. And while many are just be
hearing about these measures for the first time, neglect may be
correct.

The mean, variance, skewness, and kurtosis are almost never the right
tools for a performance-minded engineer. Moment-based measures are not
trustworthy messengers of the critical engineering metadata we seek.

Moment-based measures are not *robust*. Non-robust statistics
simultaneously:

* Bend to skew by outliers
* Dilute the meaning of those outliers

An outlier is any data point distant from the rest of the
distribution. "Outlier" may sound remote and improbable, but in real
systems they occur everywhere, making moment-based statistics
uninformative and even dangerous. Outliers often represent the most
critical data for a troubleshooting engineer.

So why do so many continue to use moments for software? The short
answer, if you'll pardon the pun: momentum. The mean and variance have
two advantages: easy implementation and broad familiarity. In reality,
that familiarity regularly leads to damaging assumptions that ignore
specifics like outliers. For software performance, the mean and
variance are useful *only* in the context of robust statistical
measures.

So, enough buildup. Lesson #1 is avoid relying solely on non-robust
descriptive statistics like the mean. Now, what robust techniques can
we turn to save the day?

# Quantile mechanics

If you've ever gotten standardized test results, or paid attention
during tax season, you're already familiar with quantiles. Quantiles
are points which subdivide a dataset's range into equal parts. Most
often, we speak of quartiles (4 parts) and percentiles (100
parts). Most nontechnical areas focus in central indicators, hence the
popularity of the *median*.

While experienced engineers are happier to see the median than the
mean, the data doesn't really get interesting until we get into the
extremes. For software performance and reliability, that means the
95th, 98th, 99th, and 99.9th percentiles. Beyond this, nothing adds
clarity like accurate bounds on the data. So we also look for the
range, formed by the minimum and maximum observed values, sometimes
called the 0th and 100th percentiles.

The challenge with quantiles and ranges is efficient computation. For
instance, the traditional way to calculate the median is to choose the
middle value, or the average of the two middle values, from a sorted
set of *all* the data. Considering all the data at once is the only
way to calculate exact quantiles. The memory required to do this for
our use cases makes this method prohibitively expensive. Still, every
application has its error tolerances, and statistics is founded on
utilitarian compromise. Using the principle of "good enough", an
engineer has ways of estimating quantiles much more efficiently.

## Dipping into the stream

As a field, statistics formed to tackle the logistical issue of
approximating an unreachable population. Even today, it's still not
possible to poll every person, taste every apple, or drive every
car. So statistics continues to provide.

In the realm of software performance, data generation and collection
is automatable. It's easy to make a measurement system *too*
automatic. The problem becomes collation, indexing, and storage. Hard
problems, replete with with hard-working people.

We're trying to make things easier. We want to avoid those hard
problems. The easiest way to avoid the hard problem of too much data
is to throw data away. Discarded data needs no storage, but if you're
not careful, it will live on, haunting data in the form of biases. We
want pristine, meaningful data, indistinguishable from the population,
just a whole lot smaller. So statistics provides us random sampling.

The twist is that we want to sample from an unknown population,
considering one data point at a time. This use case calls for a
special corner of computer science: online algorithms, a subclass of
streaming algorithms. "Online" implies only individual points are
considered in a single pass. "Streaming" implies the program can only
consider a subset of the data at a time, but can work in batches or
run multiple passes. Fortunately, Donald Knuth popularized an elegant
approach that enables random sampling over a stream: Reservoir
Sampling.

First we designate a *counter*, to be incremented for every data point
seen. The *reservoir* is generally an ordered container of a certain
*size*, such as a list or array. Now we can begin adding data. Until
we encounter *size* elements, elements are added directly to
*reservoir*. Once *reservoir* is full, incoming data points have a
*size*/*counter* chance to be added. This way *reservoir* is always
representative of the dataset as a whole, and is just as likely to
have a data point from the beginning as it is from the end. All this,
with bounded memory requirements, and very little computation.

In simpler terms, the reservoir progressively renders a scaled down
version of the data, like a fixed-size thumbnail. Reservoir sampling's
ability to handle populations of unknown size fits perfectly with
tracking response latency and other metrics of a long-lived server
process.

## Interpreting reservoir data

Once you have a reservoir what are the natural next steps? At PayPal
we do what so many others do:

1. Look at the range (min and max) and quantiles of interest
   (generally median, 95th, 99th, 99.9th percentiles)
2. Visualize the CDF and histogram to get a sense for the shape of the
   data, usually by loading the data in a Jupyter notebook and using
   Pandas, matplotlib, and occasionally bokeh.

And that's it really. Beyond this we are usually adding more
dimensions, like comparisons over time or between datacenters. Having
the range, quantiles, and sampled view of the data really takes so
much of the guesswork out that you end up saving time. Tighten a
timeout, add a retry, test, and deploy. Or, if something more drastic
is necessary, you know that when you've fixed it, you have the right
numbers to back up your success.

<!--

### Combo

One of the major advantages of moment-based measures like the mean and
variance is the ease with they can be combined together. As long as
you have a count, you can create a weighted equation that will give
you a mean representative of two populations combined. There is no
such operation for a median. The median of medians is not the median
of the whole, and the mean of the medians is right out.

Reservoir sampling readds this power of dataset combination, much more
robustly than moment-based statistics. With the counts of the
associated data, we can create weighted datasets, suitable for merging
into a reservoir representing more data. This is like taking two
thumbnails, scaling them up, interleaving them, and scaling back down
again. This mergeability is incredibly important for algorithms
running over streams of data that often make the most sense when
rolled up across processes, machines, and datacenters.

### p-values

Reservoir sampling introduces one subtle statistical
nuance. Because the entire population is considered, and points are
uniformly randomly selected, hypothesis-testing metrics like the
p-value are meaningless here. Hypothesis testing is used as a checksum
to test that the data is as random as we expect it to be according to
a given distribution. But our sample is random by definition,
guaranteed by the accuracy of your random number generator of
choice. Furthermore, classical reservoir sampling as described here
does not assume a distribution, so it is not possible to compute a
p-value. Accuracy is instead measured directly as a function of the
number of points configured in your reservoir. Low resolution will
lead to poor accuracy.

-->

<!--
Not pre-selecting the quantile points also enables better probability
density estimation with techniques like KDE.

Histograms are massively useful for engineering applications
-->

## Reservoir reservations and recommendations

Reservoir sampling does have its shortcomings. In particular, like an
image thumbnail, accuracy is only as good as the resolution
configured.

Good implementations of reservoir sampling will already track the
maximum and minimum values, but for engineers interested in the edges,
we recommend keeping an increased set of the exact outliers. For
example, for critical paths, use a min heap to explicitly track the
highest response times observed in the last hour.

Depending on your runtime environment, resources may come at a
premium. Reservoir sampling requires very little processing power,
provided you have an efficient PRNG. Don't bother checking, even your
Arduino has one. But memory costs can pile up. Generally speaking,
accuracy scales with the square root of size; twice as much accuracy
will cost you four times as much memory, so there are diminishing
returns. At PayPal, the typical reservoir is allocated 16,384 floating
point slots, totalling 64 kilobytes. At this rate, the human developer
runs into their memory limits before the server does. Tracking 500
variables only takes 8 megabytes. As a developer, remembering what
they all are is a different story.

## Learning from reservoirs

Usually, reservoir sampling gets us what we want and we can get on
with non-statistical development. But sometimes, the situation calls
for a more tailored approach.

At various points at PayPal, we've worked with q-digests and biased
quantile estimators and plenty of other advanced algorithms for
handling performance data. After a lot of experimentation, two
approaches remain our go-tos, both of which are much simpler than
one might presume.

The first approach, bucketed counting, establishes ranges of interest,
called buckets, based on statistics gathered from a particular
reservoir. While reservoir counting is data agnostic, looking only at
a random value to decide where to put the data, bucketed counting
looks at the value, finds the bucket whose range includes that value,
and increments the bucket's associated counter. The value itself is
not stored. The code is simple, and the memory consumption is even
lower, but the key advantage is the execution speed. Bucketed counting
is so low overhead that it allows statistics collection to permeate
much deeper into our code than other algorithms would allow.

The second, more advanced approach, is a classic, P2 quantile
estimation. Sometimes we look at a distribution and decide we need
more resolution for certain percentiles. P2 lets us specify the
percentiles ahead of time, and it updates those values on every single
observation. Conceived in the electronics industry of the 80s, P2 is a
pragmatic online percentile algorithm designed for very simple
devices. The memory consumption is very low, but due to the math
involved, more computation is involved as compared to reservoir
sampling and bucketed counting. Furthermore, we've never seen anyone
attempt combination of P2 estimators, but we assume it's
nontrivial. Still, for our use cases, P2 answers real questions and we
can empirically vouch for P2's continued accuracy into the software
domain.

These approaches both take something learned from the reservoir sample
and apply it toward doing less. Buckets provide answers in terms of a
preconfigured histogram, P2 provides answers at specific quantile
points of interest. Lesson #3 is to choose your statistics to match
the questions you need to answer. If you don't know what those
questions are, stick to general tools like reservoir sampling.

# Next steps

Statistics is a huge field, and engineering offers a huge range of
applications. There are a lot of places to go from here, and we wanted
to offer some running starts for the areas we feel are natural
extensions to the fundamentals above.

## Instrumentation

We focused a lot on statistical fundamentals, but how do we generate
relevant datasets in the first place? Our answer is through structured
instrumentation of our components. With the right hooks in place the
data will be there when we need it, whether we're dropping everything
to debug an issue or when we have a spare cycle to improve performance.

One of the many advantages to investing in instrumentation early is
that you get a sense for the performance overhead of data
collection. Reliability and features far outweigh performance in the
enterprise space. Many critical services I've worked on could be
multiple times faster without instrumentation, but removing this
aspect would render them unmaintainable.

Good work takes cycles. An airplane could carry more passengers
without all those heavy dials and displays up front. For most
services, it's not hard to imagine logging and metrics collection is
second only to the features themselves. Going further, being forced to
choose does not bode well for the reliability record of the
application and/or organization.

Much of PayPal's Python services' robustness can be credited to a
reliable remote logging infrastructure, combined with a robust,
unobtrusive instrumentation framework.

## More advanced statistics

We focused here on descriptive, non-parametric statistics, most of
which was numeric. Statistics is a very large field, with very
specific terminology. Knowing the right vocabulary means the
difference between the right answer and no answer. Here are the areas
to expand into:

**Non-parametric statistics** gave us quantiles, but also offers so
much more. Generally, *non-parametric* describes any statistical
construct that does not make assumptions about probability
distribution, e.g. normal or binomial. This means it offers the most
broadly-applicable tools in the descriptive toolbox. This includes
everything from the familiar histogram to the sleeker kernel density
estimation. There's also a wide variety of nonparametric statistical
tests aimed at quantitatively discovering your data's distribution and
opening up the wide world of parametric methods.

**Parametric statistics** contrast with non-parametric statistics in
that the data is presumed to follow a given probability
distribution. If you've established a model using inferential
statistics, and that model can be put in terms of standard
distributions, you've given yourself a powerful set of abstractions
with which to reason about your system. We could do a whole article on
the probability distributions we expect from different parts of our
Python backend services (hint: expect a lot of [fish][poissond] and
[telephones][erlangd]). Teasing apart the curves inherent in your
system is quite a feat, but don't drift too far from the real data,
and as with any extensive modeling exercise heed the cautionary song
of the black swan.

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

**Categorical statistics** contrast with numerical statistics in that
the data is not mathematically measurable. Categorical data can be
big, such as IPs and phone numbers, or small, like user languages. The
key metrics in this area are around counts, or cardinality. Some PayPal
components have used HyperLogLog and Count-Min sketches for
distributable streaming cardinality estimates. While reservoir
sampling is much simpler, and can be used for categorical data as
well, HLL and CMS offer increased space efficiency, and more
importantly: proven error bounds. After grasping reservoir sampling,
but before delving into advanced cardinaltiy structures, you may want
to have a look at [boltons ThresholdCounter][btc], the heavy hitters
counter used extensively in PayPal's Python services.

[btc]: http://boltons.readthedocs.org/en/latest/cacheutils.html#threshold-bounded-counting

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
shoehorning. Time-bucketing contorts the data, leading to fewer ways
to safely combine samples and more shadows of misleading correlations.

**Moving statistics** are another area that can be combined with time
to create a powerful metric. For instance, the exponentially-weighted
moving average (EWMA), famously used by UNIX to represent load:

```load average: 1.37, 0.22, 0.14```

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
investigations, even a basic understanding of the bathtub curve can
provide insight into lifespans of running processes. When the software
industry gets to a point where it leverages this field as much as the
hardware industry, the technology world will have reached a better
place.

# Self-evaluation

Whether you feel like evaluating yourself or interviewing a job
candidate, here are some questions that a dedicated engineer intent on
building complex systems should be able to answer:

1. What statistical techniques can one use to measure performance and
   reliability?
2. What are the strengths and weaknesses of the arithmetic mean as a
   performance statistic?
3. What does it mean for a statistic to be robust?
4. How does one handle outliers in performance metrics?
5. What is the difference between a streaming algorithm and an online algorithm?
6. What are three beneficial features of reservoir sampling?

These are pretty open-ended questions, but for each of the answers I
would expect at least:

1. Statistical measures include mean, variance, median, and
   percentiles. Points for anything else that is non-parametric or
   robust.
2. The mean is too sensitive to outliers, and yet not powerful enough
   to the importance of those outliers to engineering applications.
3. Robust statistics are resistant to influence by outliers.
4. Outliers should be recorded and tracked as strong indicators of
   system weakness. The last thing I want to hear is about trimming or
   other techniques that treat outliers as noise or flukes.
5. An online algorithm *is* a streaming algorithm, but with more
   limits on its resources. Alternatively, online algorithms are the
   greediest streaming algorithms.
6. Reservoir sampling has many benefits:
    1. Quantile-oriented, robust, non-parametric
    2. Consistent, configurable memory usage
    3. Low CPU usage
    4. All data within the sample are real points, not interpolated
    5. Reservoirs are combinable, enabling rollups
    6. Quantile cutpoints are not preselected, enabling better
    visibility into distribution shape, including techniques like
    histograms and kernel density estimation.
