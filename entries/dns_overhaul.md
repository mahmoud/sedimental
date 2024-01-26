---
title: "Enterprise Overhaul: Resolving DNS"
publish_date: 3:13am December 21, 2015
tags:
  - python
  - code
  - work
---

<!-- Enterprise Overhaul: Resolving DNS -->
<!-- Overhaul your DNS Resolution, Enterprise-style -->
<!-- Overhauling DNS Resolutions for Enterprise Environments -->
<!-- aka Using DNS in Enterprise Environments -->
<!-- aka "In With The Old: Enterprise DNS Considerations" -->

_Originally published on
[the PayPal Engineering blog][pp_eng_blog]. Republished here with
minor modifications and updates._

[pp_eng_blog]: https://medium.com/paypal-tech/enterprise-overhaul-resolving-dns-521dac3ab601

Everyone assumes all software engineers are great with numbers. If
only they knew the truth. How many people's phone numbers can you
recite? No peeking and emergency numbers don't count! Don't worry if
you couldn't name that many. Here's the real embarrassing test of the
day: How many sites' IP addresses can you name? No pinging and local
subnets don't count!

<img width="50%" title="Most telephones still looked like this when
DNS was invented." src="/uploads/illo/mjc/telephone.png"><br/>_Most
telephones still looked like this when DNS was invented. Not pictured:
the phonebook._

Back in the mid-1980s, the first Domain Name System ([DNS][dns])
implementations started putting our IP addresses into server-based
contact lists and the Internet has never looked the same since. These
days, we may associate DNS with large-scale networks, but it's
important to remember that DNS really came from a very human distaste
for numbers. Thirty years later, we engineers use it so much in normal
Internet usage that it's easy to take for granted.

[dns]: https://en.wikipedia.org/wiki/Domain_Name_System

DNS may be a mature, but the fact of networks is that it always takes
at least two to tango. As new technologies and deployments emerge, the
implications of integrating with DNS must still be revisited. Your
datacenter is not the Internet, even if it's in the cloud. This post
looks at how to resolve a few of the DNS pitfalls preying on precious
reliability and performance.

<!-- prevent potential pitfalls that prey on projects' precious
  performance and predictability. -->

## A protocol precaution

The client side of DNS, _resolution_, is virtually all
[UDP][udp]. This is interesting because UDP is designed as a
lightweight, [unreliable][net_reliability] transport. However, in many
of the most common use cases, DNS calls precede [TCP][tcp]-backed
[HTTP][http] and other protocols based on reliable transports. This
fundamental difference changes many things. Looking upstream, UDP does
not load-balance like TCP. Because UDP is not connection-oriented or
congestion-controlled, DNS traffic will act very differently at scale.

[udp]: https://en.wikipedia.org/wiki/User_Datagram_Protocol
[tcp]: https://en.wikipedia.org/wiki/Transmission_Control_Protocol
[http]: https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol
[net_reliability]: https://en.wikipedia.org/wiki/Reliability_%28computer_networking%29

So our first lesson is to stay true to the stateless nature of UDP and
avoid putting [stateful load balancers][f5_load_bal] in front of DNS
infrastructure. Instead, configure clients and servers to conform to
the built-in load-handling architecture of DNS. The Internet's DNS
"deployment" is load balanced via its
[inherent hierarchy][dns_hierarchy] and [IP Anycast][anycast].

[f5_load_bal]: https://www.f5.com/pdf/deployment-guides/dns-load-balancing-dg.pdf
[dns_hierarchy]: https://www.novell.com/documentation/dns_dhcp/?page=/documentation/dns_dhcp/dhcp_enu/data/behdbhhj.html
[anycast]: https://en.wikipedia.org/wiki/Anycast

## Client integration

Back on the client side, you can do a lot to optimize and robustify your
application's DNS integration. The first step is to take a hard look
at your stack. Whether you're running Python, Java, JavaScript, or C++, the
defaults may not be for you, especially when working with traffic within the
datacenter.

For example, while not supported here at PayPal, it's safe to say
[Tornado][tornado] is a popular Python web framework, with many
asynchronous networking features. But, silently and subtly,
[DNS is not one of them][tornado_tweet]. Tornado's
[default DNS resolution behavior][tornado_dns_docs] will block the
entire IO event loop, leading to big issues at scale.

[tornado]: https://github.com/tornadoweb/tornado
[tornado_tweet]: https://twitter.com/etrepum/status/585544395006550016
[tornado_dns_docs]: http://tornado.readthedocs.org/en/latest/netutil.html#tornado.netutil.BlockingResolver

And that's just one example of library DNS defaults jeopardizing
application reliability. Third-party packages and sometimes even
builtins in Java, Node.js, Python, and other stacks are full of hidden
DNS faux pas.

For instance, the average off-the-shelf HTTP client seems like a
neutral-enough component. Where would we be without reliable standbys
like [wget][wget]? And that is how the trouble starts. The DNS
defaults in most tools are designed to make for good Internet
citizens, not reliable and performant enterprise foundations.

[wget]: https://en.wikipedia.org/wiki/Wget

<a target="_blank"
href="https://en.wikipedia.org/wiki/Domain_Name_System#Client_lookup"><img
width="50%" title="The hops Internet applications make for you."
src="/uploads/DNS_in_the_real_world.svg.png"></a><br/>_The hops Internet-connected
applications make for you. It's no wonder the default timeout is 5000
milliseconds._

The first difference is name resolution timeouts. By default,
[resolve.conf][resolv_conf], [netty][netty_dns], and
[c-ares][cares_dns] (gevent, node.js, curl) are all configured to a
whopping **5 seconds**. But this is your enterprise, your service, and
your datacenter. Look at the [SLA][sla] of your service and the
reliability of your DNS. If your service can't take an extra 5000
milliseconds some percentage of the time, then you should lower that
timeout. I've usually recommended 200 milliseconds or less. If your
infrastructure can't resolve DNS faster than that, do one or more of
the following:

1. Put the authoritative DNS servers topologically closer.
2. Add caching DNS servers, maybe even on the same machine.
3. Build application-level DNS caching.

[netty_dns]: https://github.com/netty/netty/blob/1b8086a6c16319c93724d65af1c805363c03b6d0/resolver-dns/src/main/java/io/netty/resolver/dns/DnsNameResolver.java#L310
[cares_dns]: http://c-ares.haxx.se/ares_init.html
[sla]: https://en.wikipedia.org/wiki/Service-level_agreement "Service-Level Agreement"
[resolv_conf]: http://linux.die.net/man/5/resolv.conf

Option #1 is purely a network issue, and a matter for network
operations to discuss. For brevity's sake, option #2
[is outside][do_bind] [the scope][ubuntu_dnsmasq] [of][djb_dnscache]
[this article][unbound]. But option #3 is the one we recommend most,
because it is bureaucracy-free and relatively easy to implement, even
with enterprise considerations.

[do_bind]: https://www.digitalocean.com/community/tutorials/how-to-configure-bind-as-a-caching-or-forwarding-dns-server-on-ubuntu-14-04
[ubuntu_dnsmasq]: https://help.ubuntu.com/community/Dnsmasq
[djb_dnscache]: http://cr.yp.to/djbdns/dnscache.html
[unbound]: https://www.unbound.net/

### Application-level DNS caching

When designing an enterprise application-level DNS cache, we must
recognize that we are not discussing standard-issue web components
like scrapers and browsers. Most enterprise services talk to a fixed
set of relatively few machines. Even the most powerful and complex
production PayPal services communicate with fewer than 200 addresses,
partly due to the prevalence of load balancing LTMs in our architecture.

For our [gevent-based Python stack][support], we use an asynchronous
DNS cache that refreshes those addresses every five minutes. Plus, the stack
warms up our application's DNS cache by kicking off preresolution of
many known DNS-addressed hosts at startup, ensuring that the first
requests are as fast as later ones.

<!-- Linux's DNS behavior is provided via glibc. The same library that
brought you string formatting and basic time functions, also
nonchalantly provides DNS capabilities, with all its nuances. (TODO:
how well does this resolver/cache play with TTLs?)-->

Some may be asking, why use a custom, application-level DNS cache when
virtually every operating system caches DNS automatically? In short,
when the OS cache expires, the next DNS resolution will block, causing
stacks without this asynchronous DNS cache to block on the next
resolution. Our DNS cache allows us to use mildly stale
addresses while the cache is refreshing, making us robust to many DNS
issues. For our use cases both the chances and consequences of
connecting to the wrong server are so minute that it's not worth
inflating outlier response times by inlining DNS. This arrangement
also makes services much more robust to network glitches and DNS
outages, as well as allowing for more logging and instrumentation
around the explicit DNS resolution so you can see when DNS is
performing badly.

## Denecessitizing DNS

The overhaul wouldn't be complete without exploring one final
scenario. What's it like to not use DNS at all? It may sound odd,
given the number of technologies built on DNS in the last 30
years. But even today, PayPal production services still communicate to
each other using a statically generated IP-address-based system, like
a souped-up [hosts file][hosts_file]. This design decision long
predates my tenure here, and for a long time I considered it technical
debt. But after collaborating with architects here and at other
enterprise datacenters, I've come to appreciate the advantages of
skipping DNS. DNS was designed for multi-authority, federated,
eventually-consistent networks, like the Internet. Even the biggest
datacenters are not the Internet. A datacenter is topologically
smaller, has only one operational authority, and must meet much
tighter reliability requirements.

[hosts_file]: https://en.wikipedia.org/wiki/Hosts_%28file%29

<img title="A little peek at PayPal's midtier-to-midtier traffic."
width="50%" src="/uploads/pp_midtier.png"><br/> _A little peek at
PayPal's midtier-to-midtier traffic. Each shrunken line of text is a
service endpoint. It looks like a lot, but each endpoint only talks to
a few others._

Whether or not your system uses DNS, when you own the entire network
it's still best practice to maintain a central, version-controlled,
"single source of truth" repository for networking
configurations. After all, even DNS server configurations have to come
from somewhere. If it were possible to efficiently and reliably push
that same information to every client, would you? Explicit
preresolution of all service names reduces the window of inconsistency
while saving the datacenter billions of network requests. If you
already have a scalable deployment system, could it also fill the
network topology gap, saving you the trouble of overhauling, scaling,
and maintaining an Internet system for enterprise use? There's a lot
packed in a question like that, but it's something to consider when
designing your service ecosystem.

## In short

So, to sum it all up, here are the key takeaways:

- Beware the pitfalls of stateful load-balancing for DNS and UDP.
- Tighten up your timeouts according to your SLAs.
- Consider an in-application DNS cache with explicit resolution.
- The fastest and most reliable request is the request you don't have to make.
- A datacenter is not the Internet.

If you're not careful, out-of-box solutions will fill your inbox with
avoidable problems. Quality enterprise engineering means taking a
microscope to libraries, with deliberate overhauling for your
organization's needs.

[support]: https://www.paypal-engineering.com/2015/03/17/introducing-support/

<!-- "DNS + HTTP: The Reliability and Performance of the Internet,
Inside the Datacenter!" - Too many might not get the joke. -->
