---
title: "Enterprise Evaluations: Reassessing DNS Integrations"
---

<!-- aka Using DNS in Enterprise Environments -->
<!-- aka "In With The Old: Enterprise DNS Considerations" -->

Everyone assumes all software engineers are great with numbers. If
only they knew the truth. How many people's phone numbers can you
recite? No peeking and emergency numbers don't count! Don't worry if
you couldn't name that many. Here's the real embarrassing test of the
day: How many sites' IP addresses can you name? No pinging and local
subnets don't count!

Back in the mid-1980s, the first Domain Name System (DNS)
implementations started putting our IP addresses into server-based
contact lists and the Internet has never looked the same since. These
days we may associate DNS with large-scale networks, but it's
important to remember that it really exists for humans and our distaste
for numbers. And now, 30 years later, we engineers use it so much as
normal Internet users that it's easy to take for granted.

DNS may be a mature technology but the fact of networks is that it
always takes at least two to tango. As new technologies and
deployments emerge, the implications of integrating with DNS must be
revisited. Your datacenter is not the Internet, even if it's in the
cloud. In this post we'll look at how to resolve a few of the DNS
pitfalls that cost precious reliability and performance.

<!-- prevent potential pitfalls that pollute/poison/prey_on projects' precious
  performance and predictability. -->

First, the protocol. Resolution, the client side of DNS, is virtually
all UDP. This is interesting because in the most common use case DNS
calls precede HTTP and other reliable-transport-based protocols, like
TCP. There are several learnings based on this fundamental
difference. Looking upstream, UDP does not load-balance like
TCP. Because UDP is not connection-oriented or congestion-controlled,
DNS traffic will act very differently at scale.

Stay true to the stateless nature of UDP and avoid putting stateful
load balancers in front of DNS infrastructure. Instead, configure
clients and servers to conform to the built-in load-handling
architecture of DNS. The Internet's DNS "deployment" is load balanced
via its inherent hierarchy and [IP Anycast][anycast].

[f5_load_balancing]: https://www.f5.com/pdf/deployment-guides/dns-load-balancing-dg.pdf
[dns_hierarchy]: https://www.novell.com/documentation/dns_dhcp/?page=/documentation/dns_dhcp/dhcp_enu/data/behdbhhj.html
[anycast]: https://en.wikipedia.org/wiki/Anycast

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

<!-- https://twitter.com/etrepum/status/585544395006550016 -->
<!-- http://tornado.readthedocs.org/en/latest/netutil.html#tornado.netutil.BlockingResolver -->

And that's just one example of library DNS defaults jeopardizing
application reliability. Packages and sometimes even builtins in Java,
Node.js, Python, and other stacks are full of hidden DNS faux pas.

For example, the average off-the-shelf HTTP client seems like a
neutral enough component. Where would we be without reliable standbys
like cURL and wget? However, the default handling of DNS in these
tools and other libraries was built for being a good citizen of the
Internet, not for the reliability and performance of an enterprise
environment.

The first main difference is name resolution timeouts. By default,
resolve.conf, [netty][netty_dns], and [c-ares][cares_dns] (gevent and node.js) are all
configured to 5 seconds. But this is your enterprise, your service,
and your datacenter. Look at the [SLA][sla] of your service and the
reliability of your DNS. If your service can't take an extra 5 seconds
some percentage of the time, then you should lower that timeout. I've
usually recommended 200 milliseconds or less. If you can't resolve DNS
that fast, do one or more of the following:

1. Put the authoritative DNS servers topologically closer.
2. Add caching DNS servers, maybe even on the same machine.
3. Build application-level DNS caching.

[netty_dns]: https://github.com/netty/netty/blob/1b8086a6c16319c93724d65af1c805363c03b6d0/resolver-dns/src/main/java/io/netty/resolver/dns/DnsNameResolver.java#L310
[cares_dns]: http://c-ares.haxx.se/ares_init.html
[sla]: https://en.wikipedia.org/wiki/Service-level_agreement "Service-Level Agreement"

The first option is purely a network issue. For the sake of brevity,
the second option [is outside][do_bind] [the scope][ubuntu_dnsmasq]
[of this article][djb_dnscache]. But the third option is one we
recommend often, mostly because it is relatively easy to implement,
even with enterprise considerations.

[do_bind]: https://www.digitalocean.com/community/tutorials/how-to-configure-bind-as-a-caching-or-forwarding-dns-server-on-ubuntu-14-04
[ubuntu_dnsmasq]: https://help.ubuntu.com/community/Dnsmasq
[djb_dnscache]: http://cr.yp.to/djbdns/dnscache.html

The first thing to recognize is that, unlike web components like
scrapers and browsers, most enterprise services talk to a fixed set of
relatively few machines. Even the most powerful and complex production
PayPal services communicate with fewer than 200 addresses.

For our gevent-based Python stack, we use an asynchronous DNS cache
that refreshes addresses every few minutes.

But why our own DNS cache when basically every OS caches DNS for you?
When the OS cache expires it will block on the next resolution,
causing stacks without this async DNS cache to block on the next
resolution. Our DNS cache allows us to use the old value while the
cache is refreshing, making us robust to many DNS issues.

(TODO: links)

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

In fact, our production stack actually kickstarts our application DNS
cache by preresolving many known DNS-addressed hosts, preheating the
cache, ensuring that the first requests are as fast as later ones.

<!-- "DNS + HTTP: The Reliability and Performance of the Internet,
Inside the Datacenter!" - Too many might not get the joke. -->



<!-- If you control all the
computers and know all the services ahead of time, why wouldn't you
precalculate and predistribute all the connection endpoint metadata? -->
