---
title: Straightforward Software Statistics
subtile: Easier development and maintenance through reintroduction
---

<img width="25%" align="right" src="/uploads/illo/stats_stopwatch.png">
Software development begins as a quest for capability, doing what
could not be done before. Once that *what* is achieved, the engineer
is left with the *how*. In enterprise software, the most frequently
asked questions are, "How fast?" and more importantly, "How reliable?"

Questions about software performance cannot be answered, or even
appropriately articulated, without statistics.

Yet most developers can't tell you much about statistics. Much like
math, statistics simply don't come up for typical projects. Between
coding the new and maintaining the old, who has the time?

Engineers must make the time. TLDR seekers can head for
[the summmary](#summary). For the dedicated few, it's time to broach
the topic, learn what works, and take the guesswork out of software. A
few core practices go a long way in generating meaningful systems
analysis. And a few common mistakes set projects way back. This guide
aims to lighten software maintenance and speed up future development
through answers made possible by the right kinds of applied
statistics.

[TOC]

# Collection and convention

To begin, let's consider a target component we want to measure and
improve. At PayPal this is often one of our hundreds of HTTP server
applications. If you were to look at our internal frameworks, you
would find hundreds of code paths instrumented to generate streams of
measurements: function execution times, request lengths, and response
codes, for instance.

We discuss more about instrumentation [below](#instrumentation), but
for now we assume these measurement points exist and focus on
numerical measurements like execution times.

The correct starting point minimizes bias. We assume the least,
treating our measurements as values of random variables. So opens the
door to the wide world of [descriptive statistics][descriptive], a
whole area devoted to describing the behavior of randomness. While
this may sound obvious, remember that much of statistics is
[inferential][inferential], dedicated to modeling future
outcomes. They may go hand-in-hand, but knowing the difference and
proper names drastically speeds up future research. **Lesson #1 is
that it pays to learn the right statistics terminology.**

[descriptive]: https://en.wikipedia.org/wiki/Descriptive_statistics
[inferential]: https://en.wikipedia.org/wiki/Inferential_statistics

Measurement is all about balance. Too little data and you might as
well have not bothered. Or worse, you make an uninformed decision that
takes your service down with it. Then again, too much data can take
down a service. And even if you keep an eye on memory consumption, you
need to consider the resources required to manage excess
data. "[Big data][big_data]" looms large, but it is not a necessary
step toward understanding big systems. We want dense, balanced data.

[big_data]: https://en.wikipedia.org/wiki/Big_data

So what tools does the engineer have for balanced measurement? When it
comes to metadata, there is never a shortage of volume, dimensions, or
techniques. To avoid getting lost, we focus on descriptive summary
statistics that can be collected with minimal overhead. With that
direction, let's start out by covering some familiar territory.

# Moments of truth
<!-- moment of truth. moment of inertia. spur of the moment. -->

Statistical moments may not sound familiar, but virtually everyone
uses them, including you. By age 10, most students can compute an
average, otherwise known as the [arithmetic mean][mean]. Our everyday
mean is known to statisticians as the first [moment][moment]. The mean
is nice to calculate and can be quite enlightening, but there's a
reason this post doesn't end here.

The mean is just the most famous of four commonly used moments. These
moments are used to create a progression that adds up to a standard
data description:

1. [**Mean**][mean] - The central tendency of the data
2. [**Variance**][variance] - The tightness of the grouping around the mean
3. [**Skewness**][skewness] - The symmetry or bias toward one end of the scale
4. [**Kurtosis**][kurtosis] - The amount of data in "the wings" of the set

[mean]: https://en.wikipedia.org/wiki/Arithmetic_mean
[moment]: https://en.wikipedia.org/wiki/Moment_%28mathematics%29
[variance]: https://en.wikipedia.org/wiki/Variance
[skewness]: https://en.wikipedia.org/wiki/Skewness
[kurtosis]: https://en.wikipedia.org/wiki/Kurtosis

These four [standardized moments][std_moments] represent the most
widely-applied metrics for describing the
[shape of a distribution][shape_dist]. Each successive measure adds
less practical information than the last, which is why skewness and
kurtosis are often omitted. And while many are just be hearing about
these measures for the first time, omission may not be a bad thing.

[std_moments]: https://en.wikipedia.org/wiki/Standardized_moment
[shape_dist]: https://en.wikipedia.org/wiki/Shape_of_the_distribution

The mean, variance, skewness, and kurtosis are almost *never* the right
tools for a performance-minded engineer. Moment-based measures are not
trustworthy messengers of the critical engineering metadata we seek.

Moment-based measures are not [**robust**][robust]. Non-robust
statistics simultaneously:

* Bend to skew by outliers
* Dilute the meaning of those outliers

An [outlier][outlier] is any data point distant from the rest of the
distribution. "Outlier" may sound remote and improbable, but they are
everywhere, making moment-based statistics uninformative and even
dangerous. Outliers often represent the most critical data for a
troubleshooting engineer.

[robust]: https://en.wikipedia.org/wiki/Robust_statistics
[outlier]: https://en.wikipedia.org/wiki/Outlier

So why do so many still use moments for software? The short
answer, if you'll pardon the pun: momentum. The mean and variance have
two advantages: easy implementation and broad usage. In reality, that
familiarity leads to damaging assumptions that ignore specifics like
outliers. For software performance, the mean and variance are useful
*only* in the context of robust statistical measures.

So, enough buildup. **Lesson #2 is avoid relying solely on non-robust
statistics like the mean to describe your data.** Now, what robust
techniques can we actually rely on?

# Quantile mechanics

If you've ever looked at census data or gotten standardized test
results, you're already familiar with [quantiles][quantile]. Quantiles
are points that subdivide a dataset's range into equal parts. Most
often, we speak of [quartiles][quartile] (4 parts) and
[percentiles][percentile] (100 parts). Measures of
[central tendency][central] tend to be the most popular, and the same
goes for the 50th percentile, the [median][median].

[quantile]: https://en.wikipedia.org/wiki/Quantile
[quartile]: https://en.wikipedia.org/wiki/Quartile
[percentile]: https://en.wikipedia.org/wiki/Percentile
[central]: https://en.wikipedia.org/wiki/Central_tendency
[median]: https://en.wikipedia.org/wiki/Median

While experienced engineers are happier to see the median than the
mean, the data doesn't really get interesting until we get into the
extremes. For software performance and reliability, that means the
95th, 98th, 99th, and 99.9th percentiles. We also look for the range
formed by the minimum and maximum values, sometimes called the 0th and
100th percentiles.

The challenge with quantiles and ranges is efficient computation. For
instance, the traditional way to calculate the median is to choose the
middle value, or the average of the two middle values, from a sorted
set of *all* the data. Considering all the data at once is the only
way to calculate exact quantiles.

Keeping all our data in memory would be prohibitively expensive for
our use cases. Instead, using the principle of "good enough", an
engineer has ways of estimating quantiles much more
efficiently. Statistics is founded on utilitarian compromise.

## Dipping into the stream

As a field, statistics formed to tackle the logistical issue of
approximating an unreachable population. Even today, it's still not
possible to poll every person, taste every apple, or drive every
car. So statistics continues to provide.

In the realm of software performance, data collection is automatable,
to the point of making measurement *too* automatic. The problem
becomes collation, indexing, and storage. Hard problems, replete with
with hard-working people.

Here we're trying to make things easier. We want to avoid those hard
problems. The easiest way to avoid too much data is to throw data
away. Discarded data may not need storage, but if you're not careful,
it will live on, haunting data in the form of biases. We want
pristine, meaningful data, indistinguishable from the population, just
a whole lot smaller. So statistics provides us
[random sampling][random_sampling].

[random_sampling]: https://en.wikipedia.org/wiki/Sampling_%28statistics%29#Simple_random_sampling

The twist is that we want to sample from an unknown population,
considering only one data point at a time. This use case calls for a
special corner of computer science: [online algorithms][online_algo],
a subclass of [streaming algorithms][streaming_algo]. "Online" implies
only individual points are considered in a single pass. "Streaming"
implies the program can only consider a subset of the data at a time,
but can work in batches or run multiple passes. Fortunately,
[Donald Knuth][knuth] helped popularize an elegant approach that
enables random sampling over a stream: [Reservoir sampling][reservoir].

[online_algo]: https://en.wikipedia.org/wiki/Online_algorithm
[streaming_algo]: https://en.wikipedia.org/wiki/Streaming_algorithm
[knuth]: https://en.wikipedia.org/wiki/Donald_Knuth
[reservoir]: https://en.wikipedia.org/wiki/Reservoir_sampling

<img width="20%" align="right" src="/uploads/illo/stats_oveflow.png">
First we designate a *counter*, which will be incremented for every
data point seen. The *reservoir* is generally a list or array of
predefined *size* Now we can begin adding data. Until we encounter
*size* elements, elements are added directly to *reservoir*. Once
*reservoir* is full, incoming data points have a *size*/*counter*
chance to replace an existing sample point. We never look at the value
of a data point and the random chance is guaranteed by
definition. This way *reservoir* is always representative of the
dataset as a whole, and is just as likely to have a data point from
the beginning as it is from the end. All this, with bounded memory
requirements, and very little computation. See
[the instrumentation section](#instrumentation) below for links to
Python implementations.

In simpler terms, the reservoir progressively renders a scaled-down
version of the data, like a fixed-size thumbnail. Reservoir sampling's
ability to handle populations of unknown size fits perfectly with
tracking response latency and other metrics of a long-lived server
process.

## Interpretations

Once you have a reservoir what are the natural next steps? At PayPal,
our standard procedure looks like:

1. Look at the min, max, and other quantiles of interest
   (generally median, 95th, 99th, 99.9th percentiles).
2. Visualize the [CDF][cdf] and [histogram][histogram] to get a sense
   for the shape of the data, usually by loading the data in a
   [Jupyter][jupyter] notebook and using [Pandas][pandas],
   [matplotlib][matplotlib], and occasionally [bokeh][bokeh].

[cdf]: https://en.wikipedia.org/wiki/Cumulative_distribution_function
[histogram]: https://en.wikipedia.org/wiki/Histogram
[jupyter]: http://jupyter.org/
[pandas]: http://pandas.pydata.org/
[matplotlib]: http://matplotlib.org/
[bokeh]: http://bokeh.pydata.org/en/latest/

<img width="35%" src="/uploads/illo/stats_pixels.png">

And that's it really. Beyond this we are usually adding more
dimensions, like comparisons over time or between datacenters. Having
the range, quantiles, and sampled view of the data really eliminates
so much guesswork that we end up saving time. Tighten a timeout,
implement a retry, test, and deploy. Maybe add higher-level acceptance
criteria like an [Apdex][apdex] score. Regardless of the performance
problem, we know when we've fixed it and we have the right numbers and
charts to back us up.

[apdex]: https://en.wikipedia.org/wiki/Apdex

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

## Reservations

<img width="30%" align="right" src="/uploads/illo/stats_lowres.png">
Reservoir sampling does have its shortcomings. In particular, like an
image thumbnail, accuracy is only as good as the resolution
configured. In some cases, the data near the edges gets a bit
blocky. Good implementations of reservoir sampling will already track
the maximum and minimum values, but for engineers interested in the
edges, we recommend keeping an increased set of the exact
outliers. For example, for critical paths, we sometimes explicitly
track the n highest response times observed in the last hour.

Depending on your runtime environment, resources may come at a
premium. Reservoir sampling requires very little processing power,
provided you have an efficient [PRNG][prng]. Even your Arduino has one
of those. But memory costs can pile up. Generally speaking, accuracy
scales with the square root of size. Twice as much accuracy will cost
you four times as much memory, so there are diminishing returns. At
PayPal, the typical reservoir is allocated 16,384 floating point
slots, totalling 64 kilobytes. At this rate, the human developer runs
into their memory limits before the server does. Tracking 500
variables only takes 8 megabytes. As a developer, remembering what
they all are is a different story.

[prng]: https://en.wikipedia.org/wiki/Pseudorandom_number_generator

## Transitions

Usually, reservoir sampling gets us what we want and we can get on
with non-statistical development. But sometimes, the situation calls
for a more tailored approach.

At various points at PayPal, we've worked with [q-digests][qdigest]
and biased quantile estimators and plenty of other advanced algorithms
for handling performance data. After a lot of experimentation, two
approaches remain our go-tos, both of which are much simpler than one
might presume.

[qdigest]: http://www.inf.fu-berlin.de/lehre/WS11/Wireless/papers/AgrQdigest.pdf

The first approach, histogram counters, establishes ranges of
interest, called bins or buckets, based on statistics gathered from a
particular reservoir. While reservoir counting is data agnostic,
looking only at a random value to decide where to put the data,
bucketed counting looks at the value, finds the bucket whose range
includes that value, and increments the bucket's associated
counter. The value itself is not stored. The code is simple, and the
memory consumption is even lower, but the key advantage is the
execution speed. Bucketed counting is so low overhead that it allows
statistics collection to permeate much deeper into our code than other
algorithms would allow.

The second approach, [Piecewise Parabolic Quantile Estimation][p2] (P2 for
short), is an engineering classic. A product of the 1980s electronics
industry, P2 is a pragmatic online algorithm originally designed for
simple devices. When we look at a reservoir's distribution and decide
we need more resolution for certain quantiles, P2 lets us specify the
quantiles ahead of time, and maintains those values on every single
observation. The memory consumption is very low, but due to the math
involved, P2 uses more CPU than reservoir sampling and bucketed
counting. Furthermore, we've never seen anyone attempt combination of
P2 estimators, but we assume it's nontrivial. The good news is that
for most distributions we see, our P2 estimators are an order of
magnitude more accurate than reservoir sampling.

[p2]: http://pierrechainais.ec-lille.fr/Centrale/Option_DAD/IMPACT_files/Dynamic%20quantiles%20calcultation%20-%20P2%20Algorythm.pdf

These approaches both take something learned from the reservoir sample
and apply it toward doing less. Histograms provide answers in terms of
a preconfigured value ranges, P2 provides answers at preconfigured
quantile points of interest. **Lesson #3 is to choose your statistics to
match the questions you need to answer. If you don't know what those
questions are, stick to general tools like reservoir sampling.**

# Next steps

There are a lot of ways to combine statistics and engineering, so it's
only fair that we offer some running starts.

## Instrumentation

We focused a lot on statistical fundamentals, but how do we generate
relevant datasets in the first place? Our answer is through structured
instrumentation of our components. With the right hooks in place, the
data will be there when we need it, whether we're staying late
to debug an issue or when we have a spare cycle to improve performance.

Much of PayPal's Python services' robustness can be credited to a
reliable remote logging infrastructure, similar to, but more powerful
than, [rsyslog][rsyslog]. Still, before we can send data upstream, the
process must collect internal metrics. We leverage two open-source
projects, fast approaching major release:

* [faststat][faststat] - Optimized statistical accumulators
* [lithoxyl][lithoxyl] - Next-generation logging and application instrumentation

One of the many advantages to investing in instrumentation early is
that you get a sense for the performance overhead of data
collection. Reliability and features far outweigh performance in the
enterprise space. Many critical services I've worked on could be
multiple times faster without instrumentation, but removing this
aspect would render them unmaintainable, which brings me to my next
point.

Good work takes cycles. All the methods described here are
performance-minded, but you have to spend cycles to regain cycles. An
airplane could carry more passengers without all those heavy dials and
displays up front. It's not hard to imagine why logging and metrics
is, for most services, second only to the features themselves. Always
remember and communicate that having to choose between features and
instrumentation does not bode well for the reliability record of the
application or organization.

For those who really need to move fast and would prefer to reuse or
subscribe, there are several promising choices out there, including
[New Relic][new_relic] and [Prometheus][prometheus]. Obviously we
don't use them internally, but they do have
[percentiles][new_relic_percentiles] and
[histograms][prometheus_histograms].

[faststat]: https://github.com/doublereedkurt/faststat
[lithoxyl]: https://github.com/mahmoud/lithoxyl
[rsyslog]: https://en.wikipedia.org/wiki/Rsyslog

[new_relic]: http://newrelic.com/
[new_relic_percentiles]: https://blog.newrelic.com/2013/10/23/histograms-percentiles-new-relic-style/
[prometheus]: http://prometheus.io/
[prometheus_histograms]: https://prometheus.io/docs/practices/histograms/

## Evaluation

You didn't just read for 15 minutes without guessing there would be a
quiz, did you?

Whether evaluating yourself or putting a candidate through the paces,
here are some questions that an engineer intent on building complex
systems should be able to answer:

1. What statistical techniques can one use to measure performance and
   reliability?
2. What are the strengths and weaknesses of the arithmetic mean as a
   performance statistic?
3. What does it mean for a statistic to be robust?
4. How does one handle outliers in performance metrics?
5. What is the difference between a streaming algorithm and an online algorithm?
6. What are three beneficial features of reservoir sampling?
7. What are two shortcomings of reservoir sampling?

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
    1. Quantile-oriented, non-parametric, and robust
    2. Low CPU overhead
    3. Consistent, configurable memory usage
    4. All data within the sample are real points, not interpolated
    5. Reservoirs are combinable, enabling rollups
    6. Quantile cutpoints are not preselected, enabling better
       visibility into distribution shape, including techniques like
       histograms and kernel density estimation.
7. Reservoir sampling lacks resolution at edges and has
   non-negligible memory usage.

I trust you to grade your own performance. If I'm lucky, some of this
will actually make its way into programming curricula. Too much is
learned the hard way, or not at all, while running software you
use. At this point, we're all educators. Let's build a more reliable,
introspectable software landscape.

## Expansion

Without detracting from the main course above, this section remains as
dessert. Have your fill, but keep in mind that the concepts above
fulfill 95% of the needs of an enterprise SOA environment like PayPal.

We focused here on descriptive, non-parametric statistics for
numerical applications. Statistics is much more than that. Having the
vocabulary means the difference between the right answer and no
answer. Here are some areas to expand into, and how they have applied
to our work:

[**Non-parametric statistics**][nonparam] gave us quantiles, but
offers so much more. Generally, *non-parametric* describes any
statistical construct that does not make assumptions about probability
distribution, e.g. normal or binomial. This means it has the most
broadly-applicable tools in the descriptive statistics toolbox. This
includes everything from the familiar [histogram][histogram] to the
sleeker [kernel density estimation][kde] (KDE). There's also a wide
variety of [nonparametric tests][nonparam_tests] aimed at
quantitatively discovering your data's distribution and expanding into
the wide world of parametric methods.

<!-- histogram linked from above -->
[nonparam]: https://en.wikipedia.org/wiki/Nonparametric_statistics
[kde]: https://en.wikipedia.org/wiki/Kernel_density_estimation
[nonparam_tests]: https://en.wikipedia.org/wiki/Nonparametric_statistics#Methods

[**Parametric statistics**][param] contrast with non-parametric
statistics in that the data is presumed to follow a given probability
distribution. If you've established or assumed that your data can be
modeled as one of [the many published distributions][listd], you've
given yourself a powerful set of abstractions with which to reason
about your system. We could do a whole article on the probability
distributions we expect from different parts of our Python backend
services (hint: expect a lot of [fish][poissond] and
[phones][erlangd]). Teasing apart the curves inherent in your system
is quite a feat, but we never drift too far from the real
observations. As with any extensive modeling exercise, heed the
cautionary song of the [black swan][black_swan].

[param]: https://en.wikipedia.org/wiki/Parametric_statistics
[listd]: https://en.wikipedia.org/wiki/List_of_probability_distributions
[poissond]: https://en.wikipedia.org/wiki/Poisson_distribution
[erlangd]: https://en.wikipedia.org/wiki/Erlang_distribution
[black_swan]: https://en.wikipedia.org/wiki/Black_swan_theory

[**Inferential statistics**][inferential] contrast with
[descriptive][descriptive] statistics in that the goal is to develop
models and predict future performance. Applying predictive modeling,
like [regression][regression] and [distribution fitting][distfit], can
help you assess whether you are collecting sufficient data, or if
you're missing some metrics. If you can establish a reliable model for
your service and hook it into monitoring and alerting, you'll have
reached [SRE][sre] nirvana. In the meantime, many teams make do with
simply overlaying charts with the last week. This is often quite
effective, diminishing the need for mathematical inference, but does
require constant manual interpretation, doesn't compose well for
longer-term trend analysis, and really doesn't work when the previous
week isn't representative (i.e., had an outage or a spike).

<!-- inferential, descriptive linked from above -->
[regression]: https://en.wikipedia.org/wiki/Regression_analysis
[distfit]: https://en.wikipedia.org/wiki/Distribution_fitting
[sre]: https://en.wikipedia.org/wiki/Reliability_engineering

[**Categorical statistics**][categorical] contrast with numerical
statistics in that the data is not mathematically
measurable. Categorical data can be big, such as IPs and phone
numbers, or small, like user languages. Our key non-numerical metrics
are around counts, or [cardinality][cardinality], of categorical
data. Some components have used [HyperLogLog][hll] and
[Count-Min sketches][cmsketch] for distributable streaming cardinality
estimates. While reservoir sampling is much simpler, and can be used
for categorical data as well, HLL and CMS offer increased space
efficiency, and more importantly: proven error bounds. After grasping
reservoir sampling, but before delving into advanced cardinaltiy
structures, you may want to have a look at
[boltons ThresholdCounter][btc], the
[heavy hitters counter][hhcounter] used extensively in PayPal's Python
services. Regardless, be sure to take a look at
[this ontology of basic statistical data types][stats_types].

[categorical]: https://en.wikipedia.org/wiki/Categorical_variable
[cardinality]: https://en.wikipedia.org/wiki/Cardinality
[hll]: https://en.wikipedia.org/wiki/HyperLogLog
[cmsketch]: https://en.wikipedia.org/wiki/Count%E2%80%93min_sketch
[btc]: http://boltons.readthedocs.org/en/latest/cacheutils.html#threshold-bounded-counting
[hhcounter]: https://en.wikipedia.org/wiki/Streaming_algorithm#Heavy_hitters
[stats_types]: https://en.wikipedia.org/wiki/Statistical_data_type#Simple_data_types

[**Multivariate statistics**][multivariate] allow you to analyze
multiple output variables at a time. It's easy to go overboard with
multiple dimensions, as there's always an extra dimension if you look
for it. Nevertheless, a simple, practical exploration of
[correlations][correlation] can give you a better sense of your
system, as well as inform you as to redundant data collection.

[multivariate]: https://en.wikipedia.org/wiki/Multivariate_statistics
[correlation]: https://en.wikipedia.org/wiki/Correlation_and_dependence

[**Multimodal statistics**][multimodal] abound in real world data:
multiple peaks or multiple distributions packed into a single
dataset. Consider response times from an HTTP service:

* Successful requests ([200s][http200]) take a "normal" amount of time.
* Client failures ([400s][http400]) complete quickly, as little work can be done with invalid requests.
* Server errors ([500s][http500]) can either be very quick (backend down) or very slow (timeouts).

[multimodal]: https://en.wikipedia.org/wiki/Multimodal_distribution
[http200]: https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#2xx_Success
[http400]: https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#4xx_Client_Error
[http500]: https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#5xx_Server_Error

Here we can assume that we have several curves overlaid, with at least
3 or 4 peaks. Maintaining a single summary is really not doing the
data justice. Two peaks really narrows down the field of applicable
techniques, and three or more will present a real challenge. There are
times when you will want to discover and track datasets separately for
more meaningful analysis. Other times it makes more sense to bite the
bullet and leave the data mixed.

[**Time-series statistics**][timeseries] transforms measurements by
contextualizing them into a single, near-universal dimension: time
intervals. At PayPal, time series are used all over, from per-minute
transaction and error rates sent to [OpenTSDB][tsdb], to the Python
team's homegrown [$PYPL][pypl]
[Pandas stock price analysis][pandas_stock]. Not all data makes sense
as a time series. It may be easy to implement certain algorithms over
time series streams, but be careful about
overapplication. Time-bucketing contorts the data, leading to fewer
ways to safely combine samples and more shadows of misleading
correlations.

[timeseries]: https://en.wikipedia.org/wiki/Time_series
[pypl]: https://www.google.com/finance?q=NASDAQ:PYPL
[tsdb]: http://opentsdb.net/
<!-- pandas linked from above -->
[pandas_stock]: http://pandas.pydata.org/pandas-docs/stable/remote_data.html

[**Moving metrics**][moving], sometimes called rolling or windowed
metrics, are another powerful class of calculation that can combine
measurement and time. For instance, the
[exponentially-weighted moving average][ewma] (EWMA),
[famously used by UNIX for its load averages][unix_load]:

```bash
$ uptime
10:53PM  up 378 days,  1:01, 3 users, load average: 1.37, 0.22, 0.14
```

This output packs a lot of information into a small space, and is very
cheap to track, but it takes some knowledge and understanding to
interpret correctly. EWMA is simultaneously familiar and nuanced. It's
fun to consider whether you want time series-style discete buckets or
the continuous window of a moving statistic. For instance, do you want
the counts for yesterday, or the past 24 hours? Do you want the
previous hour or the last 60 minutes? Based on the questions people
ask about our applications, PayPal Python services keep few moving
metrics, and generally use a lot more time series.

<!-- wish I had a better link -->
[moving]: https://en.wikipedia.org/wiki/Moving_average
[ewma]: https://en.wikipedia.org/wiki/Moving_average#Exponential_moving_average
[unix_load]: https://en.wikipedia.org/wiki/Load_%28computing%29

[**Survival analysis**][survival] is used to analyze the lifetimes of system
components, and must make an appearance in any engineering article
about reliability. Invaluable for simulations and post-mortem
investigations, even a basic understanding of
[the bathtub curve][bathtub] can provide insight into lifespans of
running processes. When the software industry gets to a point where it
leverages this analysis as much as the hardware industry, the
technology world will undoubtedly have reached a better place.

[survival]: https://en.wikipedia.org/wiki/Survival_analysis
[bathtub]: https://en.wikipedia.org/wiki/Bathtub_curve

<a name="#summary"></a>
# Summary

It's been a journey, but I hope you learned something new. If nothing
else, you know how we do it here at PayPal. Remember the three
lessons:

1. Statistics is full of very specific terminology and techniques that
   you may not know that you need. It pays to take time to learn them.
2. Averages and other moment-based measures don't cut it for software
   performance and reliability. Never underestimate the outlier.
3. Use quantiles, counting, and other robust metrics to generate
   meaningful data suitable for exploring the specifics of
   your software.

If you would like to learn more about statistics, especially branching
out from descriptive statistics, I recommend [Allen Downey][adowney]'s
video course [Data Exploration in Python][dep], as well as his free
books [Think Stats][thinkstats] and [Think Bayes][thinkbayes]. If you
would like to learn more about enterprise software development, or
have developers in need of training, take a look at my new video
course, [Enterprise Software with Python][esp]. It includes even more
software fundamentals informed by PayPal Python development, and is
out now on [oreilly.com][esp_oreilly] and [Safari][esp_safari].

I hope you found this a useful enough guide that you'll save yourself
some time, either by applying the techniques described or subscribing
and sharing the link with other developers. Everyone needs a
reintroduction to statistics after a few years of real work. Even if
you studied statistics in school, real work, real data, and real
questions have a way of making one wonder who passed those statistics
exams. As interconnectivity increases, a rising tide of robust
measurement floats all software engineering boats.

[adowney]: http://allendowney.blogspot.com/
[dep]: http://shop.oreilly.com/product/0636920044932.do
[thinkstats]: http://greenteapress.com/thinkstats/
[thinkbayes]: http://greenteapress.com/wp/think-bayes/
[esp]: http://sedimental.org/esp.html
[esp_oreilly]: http://shop.oreilly.com/product/0636920047346.do
[esp_safari]: http://techbus.safaribooksonline.com/video/programming/python/9781491943755

[p2_impl]: https://github.com/mahmoud/lithoxyl/blob/master/lithoxyl/p_squared.py
[p2_paper]: http://www.cs.wustl.edu/~jain/papers/ftp/psqr.pdf
[vividcortex]: https://www.vividcortex.com/blog/why-percentiles-dont-work-the-way-you-think
