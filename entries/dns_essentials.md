---
title: DNS Essentials
---

Everyone assumes all software engineers are great with numbers. If
only they knew the truth. How many people's phone numbers can you
recite? No peeking and emergency numbers don't count! Don't worry if
you couldn't name that many. Here's the real embarrassing test of the
day: How many sites' IP addresses can you name? No pinging and local
subnets don't count!

Back in the mid-1980s, the first DNS implementations started putting
our IP addresses into server-based contact lists and the Internet has
never looked the same since. These days we may associate DNS, the
Domain Name System, with large-scale networks, but it's important to
remember that it was created for humans and our distaste for
numbers. And now, 30 years later, we engineers use it so much as
normal Internet users that it's easy to take for granted.

(TODO: thesis statement here. something along the lines that we all
need reminders that integrating with even the most mature systems
requires care and effort.)

First, the protocol. A resolver, the client side of DNS, is virtually
all UDP. This is interesting because in the most common use case DNS
calls precede HTTP and other reliable-transport-based protocols, like
TCP. There are several learnings based on this fundamental
difference. Looking upstream, UDP does not load-balance like
TCP. Because UDP is not connection-oriented or congestion-controlled,
DNS traffic will act very differently at scale. Avoid putting load
balancers in front of DNS infrastructure. Instead, configure clients and
servers to conform to the built-in load-handling architecture of DNS.

On the client side, you can do a lot to optimize and robustify your
application's DNS integration. The first step is to take a hard look
at your stack, whether it's Java, JavaScript, or even Python, the
defaults may not be for you, especially if this is traffic within the
datacenter.

For example, it's safe to say Tornado is a popular Python web
framework, with many asynchronous networking features. However,
silently and subtly, DNS is not one of them. Tornado's default DNS
resolving behavior will block the entire IO event loop, leading to big
issues at scale.

We use an async DNS cache that refreshes values every five
minutes. But why our own DNS cache when basically every OS caches DNS
for you? When the OS cache expires it will block on the next
resolution, causing stacks without this async DNS cache to block on
the next resolution. Our DNS cache allows us to use the old value
while the cache is refreshing, making us robust to many DNS issues.

* DNS is a mature technology, and that makes it easy to trivialize and
  take for granted. The fact is, new technologies and deployments
  emerge, and the caveats and implications of integrating with DNS
  have to be revisited.
* Casual mentions of "DNS" group together the protocol, server
  infrastructure, and specific application integrations.
* In this post we'll unpack this a bit, discussing a few of the
  specific lessons learned at PayPal and how to resolve pitfalls that
  cost projects precious reliability and performance.
  <!-- prevent potential pitfalls that pollute/poison/prey_on projects' precious
  performance and predictability. -->

<!-- https://twitter.com/etrepum/status/585544395006550016 -->
<!-- http://tornado.readthedocs.org/en/latest/netutil.html#tornado.netutil.BlockingResolver -->

This post wouldn't be complete without exploring one final
scenario. What's it like to not use DNS at all? Sounds crazy, and for
most systems these days it is. But even now PayPal is still a
primarily IP-based system. This design decision long predates my
tenure here, but recently I've come to appreciate it. A datacenter is
not the Internet. Unlike the Internet, a datacenter only has one
operational authority. When you control the entire datacenter, even if
you're using DNS, it's still best to maintain a central,
version-controlled repository of networking configurations. After all,
the DNS configurations have to come from somewhere. When it's possible
to efficiently and reliably push that same information to every
client, then you save the datacenter billions of DNS requests by
preresolving all names.

<!-- "DNS + HTTP: The Reliability and Performance of the Internet,
Inside the Datacenter!" - Too many might not get the joke. -->



<!-- If you control all the
computers and know all the services ahead of time, why wouldn't you
precalculate and predistribute all the connection endpoint metadata? -->
