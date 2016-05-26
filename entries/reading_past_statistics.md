---
title: Reading Past Statistics
---

In under one week, Statistics for Software blew past 10 Myths for
Enterprise Python and became the most visited post in the history of
the PayPal Engineering blog. This bodes well as an indicator of
increased focus on software quality.

There were enough emails and comments to warrant a few quick follow
ups, all loosely related to the theme of immediate applications.

# Benchmarks

The saying in software goes that there are lies, damned lies, and
software benchmarks.

Any framework declaring performance as a feature must include
measurement instrumentation as an interface to that feature. One
cannot simply benchmark and claim performance. To claim performance
means to claim it is suitable for performance-critical
situations. There is no performance-critical situation where
measurement is not also necessary.

Instead, we see a glut of microframeworks, swearing off features in
the name of speed. Speed cannot be a built-in property of a
framework. Yes, F1 race cars are very focused on weight reduction. But
it's not shaving off grams to set speed or weight records. Engineers
are making room for
[more safety, metrics, and alerting][f1_telemetry]. Once upon a time,
this was not the case. Technology has come a long way since then.

[f1_telemetry]: https://www.metasphere.co.uk/telemetry-data-journey-f1/

To honestly claim performance on a featuresheet, a modern framework
*must* provide a fast, reliable, and resource-conscious measurement
subsystem, as well as a clear API for accessing the measurements. You
can add a toggle to disable these measurements for engineers who enjoy
such activities as not wearing seatbelts and texting while driving.

Long story short, microbenchmarks, already in the penalty box for lack
of reproducibility and intentional mismeasurement, have officially
struck out. Echos and ping-pongs are worth less than their namesakes
in an age when it is more important to provide a useful, idiomatic
facility for measuring every individual system's real performance.

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

## Evaluation

You didn't just read all that without expecting a quiz, did you?

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

# Sharing

As with 10 Myths of Enterprise Python and many other guides, the
people who would find the article on their own are not the people who
need to read it most. They are people who don't shy away from reading
and would likely converge on their own when it comes to the
fundamentals discussed.

My real hope is that I've written some significant subset of those
convergent conclusions, and that I've lightened the load on well-read
developers, who now have a reference to which they can direct others.
