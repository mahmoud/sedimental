---
title: 'Should. Just. Go away.'
entry_id: should_just_go_away
---

Change is in the air. Where software is concerned, change can seem
like the only constant. All the more reason why communication around
change is critical.

Communication, like code, is susceptible to antipatterns. Three
antipatterns in particular jeopardize successful changes, and all
three cram together in one disastrous phrase:

> ... **should just go away**.

Let's break down these terms before they break down your channels of
communication.

# Should

"Should" lives two lives, neither of which are great. In its
descriptive sense, "should" is aspirational, and not very
descriptive. "This should be working," is a far cry from, "This is
working."

In the prescriptive sense, "should" is the ultimate weasel word. It
places obligation on the advisee, but leaves an out for
the advisor. If you're going to backseat drive, at least put a modicum
of commitment into it. Good technical discussions address the *musts*
before the *shoulds*. There is a reason they're called requirements.

Beneath this simple truth, there is a severe implication. In its
simplest sense, "you should try this," translates to, "if you don't do
this, I will respect you less." Few would say this outright, but this
negativity still sneaks in to raise tensions in design discussions.

# Just

Favored among drive-by designers, backseat architects, and silver
bullet salespeople, no word is more hazardous to early stage projects
than *just*.

> "You should just use X"

This kind of reductivism waves off the hidden complexity inherent in
almost all serious development. It almost always belies excessive
attachment to one's existing mental models and an eagerness to stop
thinking about a problem, not a great mindset for engineering
challenges.

> "This is just a graph/satisfiability problem"

Even when a mental model is technically correct, labeling a problem
does not solve it. Experienced engineers know that translating a
general solution to a specific implementation is far from trivial.

Trivialization is a reflex used to fortify oneself against the scary
abyss of the unknown. Consider a medical scenario, "I'm sure it's just
a rash," sounds more like hopeful comfort than a diagnosis. Educated,
accountable opinions demand be more precision and nuance.

# Go away

Contrary to the wishes of new leaders looking to make their mark,
working legacy systems do not simply *go away*. As a technology
consumer in the open market, one might get the impression that tech
comes and goes all on its own.

Software creators and maintainers inside of organizations have access
to a clearer view. Legacy systems must be migrated, deprecated, and
removed in a process of diminishing returns and increasing difficulty.

Diminishing returns, combined with legacy stigma-fatigue, leads to
aborted migration efforts, which results in shaky foundations for
future projects.

Because demand for software outstrips supply, all focus is on building
and installation. This means that engineers are far more experienced
at creation than deprecation.[^1] If your project is an earnest
deprecation effort, identify and tackle the hardest parts first. Do
not delude yourself into thinking that momentum will carry you
through, and do not expect the reduction curve to look anything like a
production curve.

<!-- https://www.newscientist.com/article/dn23076-how-to-make-a-skyscraper-disappear/ -->

# In short

*Should*, *just*, and *go away* are signs of a defensive reflex that
leads to short-term underestimation and long-term frustration.

Generally, all three terms are part of an antipattern of wishful
thinking. Overlooking the dangerous possibility of getting what one
wishes for, too much wishful thinking is exhausting. The only known
antidote is maturity rooted in realism.

[^1]: I hope one day we as an industry can be as considerate in our
      deprecation as [this Japanese construction group][taisei] has
      proved to be. Rather than blowing up the building, disturbing
      the environment, they disassemble it floor by floor. This
      careful deconstruction is even more impressive a feat than
      building Burj-e-Khalifa.

[taisei]: https://www.newscientist.com/article/dn23076-how-to-make-a-skyscraper-disappear/

<!-- The [truth table](https://en.wikipedia.org/wiki/Truth_table) of
"should" says it all:

* If someone does not take the advice and it comes back to bite them,
  then the advisor can gloat and feel superior.
* If someone does not and there are no consequences, then the advisor
  can simply say "well you didn't *have* to".
* If someone does and it helps, again the advisor gloats.
* If someone does and it does not help, again the advisor

If it were that easy, then let the advisor prove the ease of the
simple solution with a little bit of leadership by example. If the
advisee is simply ignorant and the advice is helpful and informative,
then state the advice more directly, without condescension or
trivialization. However, nine times out of ten, there are reasons why
the solution hasn't already been implemented. These reasons are
usually either difficult to articulate or inappropriate to state
(e.g., "we tried your proposed solution and it sucked, but you're my
boss")

Don't kill the conversation. Don't take your frustration with the
world out on an earnest developer doing their best. Take a deep breath
and drop the "should".  -->
