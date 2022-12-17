---
title: The Trouble with Tracebacks
---

Whether you call them tracebacks, backtraces, or stack traces, you've
probably been looking at them since you first typo'd, "Hello, world!"
And like the proverbial boiled frog, you've seen them grow longer and
more complex as you've advanced along your software journey.

Some tracebacks tell you everything you need to know, more don't tell
you enough, but almost all of them tell you too much. What do I mean?

(Picture of Django/Postgres stack trace with an annotation highlighting all the
frames you didn't write and don't care to know about.)

See all those frames that have very little to do with the software you
wrote? You have to hunt to find lines you can practically do anything
about. Probably a couple at the top, or a couple at the bottom.

While you've stepped up your software game you've gotten better
at reading tracebacks. But have you gotten better at writing them?

Python is kind enough to provide a minimal general traceback that
works for a lot of general Python. But as your domain leaves the realm
of general Python, spilling out the implementation details of your
library can make it harder to debug for library consumers and
application maintainers.

# Solution

glom transforms data. Prior to version 2X.XX, glom users debugged
errors with the default Python traceback. We realized the
implementation details leaking out of that stack trace distracted the
library user from valuable information that could be used to debug
their data or glom spec.

(Before/after glom stack traces.)

It may look unfamiliar at first, but only the "after" stack is
actually worth the time it takes to read.

Library developers: Your debugging story is part of your library's
developer experience. If your tracebacks aren't worth reading, you're
just a couple errors away from your library not being worth using.

Other points:

  * We may default to thinking that tracebacks are objective and
    complete representations of the program state at the time of
    error, but in reality, tracebacks are convenient truths. Putting
    aside threads and other gotchas, there are two ways in which
    tracebacks are tailored in Python:
    
  * Many libraries implemented in C do not expose every function call
    as a visible stack frame, in part because this would be excessive
    perf overhead.
  
  * Python has `__tracebackhide__` as a convention for a reason.

  * The opacity of, e.g., the re module, is more of a feature than a
    bug.

---

As a riddle: What is it that sometimes tells you what you needed, usually
doesn't tell you what you wanted, but almost always tells you too much?

Why, the humble stack trace of course!