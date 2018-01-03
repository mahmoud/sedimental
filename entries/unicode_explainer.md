---
title: Unicode Explainer
---

One of my most-commonly delivered lessons is on understanding Unicode
and using it in Python. These are two surprisingly different things,
and I'm not sure I've ever seen a school curriculum cover it well. The
Unicode Consortium had been around for almost 30 years when I went to
university, and all I got about Unicode was:

> "ASCII and ANSI are too English-centric. There are a lot of
> languages other than English. Thus, Unicode."

Not that this lesson is just for new grads. You can get surprisingly
far in software engineering without a solid grasp of Unicode, in part
thanks to library maintainers who learned things the hard way and made
their libraries robust.

Now, I am one of those maintainers. Text and bytes handling may be the
biggest source of bugs in all the software I work on, so here is the
one-page rundown I give everyone I work with, to make sure we're all
on the same page.

# History

I'll make this short. In the beginning, there was the telegrpah and
Morse code. The code let Americans translate words to binary. So some
cowboy's cousin could press a button a few times, and someone the next
town over would be able to write a message. "P" became ".--." and
"python" became ".--. -.-- - .... --- -.". Click to listen. That's
information. Letters encoded as bits.

This worked great for over a hundred years, and is still in minor
usage today. But technology progressed, and telephones took over for
human-interactive communication, while computers for automated
communication. This happened by way of teletype, and we still see TTYs
in *nix systems.

The bigger artifact of teletype is the ASCII encoding, which was like
Morse Code, but with a more powerful alphabet. Everything from
uppercase and lowercase letters to control characters, including ones
to backspace and even ring a bell.

The A in ASCII stands for American, and indeed ASCII, with only 128
characters in its roster, is not going to work well for other
languages. What it did work well enough for was the formative
computers of the 50s-90s. As engineers, we're all familiar with the
byte, and it's no coincidence that ASCII's 7 bits fit into the 8-bit
byte (with a whole bit to spare!).

So we need a new alphabet. But all this hardware now works on bytes,
and bytes, with their nice power-of-2 number of bits, work great on
hardware. Despite growing up together, it's time for human written
communication to graduate beyond ASCII and bytes.

# Modern usage

## Basic philosophy

Text is for humans. Bytes are for computers.

Almost everything handled by your software will come from bytes. You
_decode_ the bytes into text. If you've gotten the parameters from a
library, it is likely that the library has decoded the bytes for you.

When you are ready to send the information back on its way, your
program will need to _encode_ the bytes. Again, if you're using a
library, it's likely that the library will do the encoding for you.

Decode as early as possible. Encode as late as possible. This way,
your program only deals with text.

## Practical Python

Python has two types, `bytes` for representing bytes, and `unicode`
for representing text. Programmers use the general term "string" to
refer to these, and Python does have a `str` type, which maps to
`bytes` in Python 2 and `unicode` in Python 3. Partly because of the
transition and mostly because I find it clearer, I use the explicit
type names.

You probably have seen, and will see again, UnicodeEncodeError and
UnicodeDecodeError. When you see these exceptions, look closely at the
code they are being raised from. Specifically, if you get an
**encode** error from a **decode** code, or vice versa, that is a
different kind of bug than when the error matches the code.

Be mindful of when you're trying to turn an object into text versus
when you're actually trying to encode it into bytes.

## Encodings

`unicode` objects have an `encode` method, and `bytes` objects have a
`decode` method, but in order to use them, you need to pass an
encoding. We already talked about one encoding, ASCII, which was
hugely influential. Now, the new encoding is UTF-8. The U stands for
Unicode, and the 8 denotes its design for compatibility with 8-bit
bytes, and, yes, ASCII.

ASCII is valid UTF-8. Anything beyond ASCII gets a special non-ASCII
control character put in front of it, which tells the decoder that
what follows should be looked up in the Unicode data tables. Python's
Unicode data is in the `unicodedata` module.

## More

* Error handlers
* Python 3's attempts to hide bytes
* Canonicalization of Unicode bytestrings

## Pitfalls

`bytes` objects cannot tell you what encoding the bytes are in. It is
possible that they have no encoding. `unicode` objects do not store
what encoding they came from. Your program will have to track and
communicate this state outside of the string itself.

## Python 2's flaws

# Links

* Morse Code translator: https://morsecode.scphillips.com/translator.html
* The maintainers of Unicode: https://en.wikipedia.org/wiki/Unicode_Consortium
* History of Unicode: https://en.wikipedia.org/wiki/Unicode#History
* The Unicode Book, written by Python core developer Victor Stinner: http://unicodebook.readthedocs.io
    * One of the clearer introductions, but still too long and with
      several confusingly worded sections.
* Nuts and bolts definitions of UTF8: https://tools.ietf.org/html/rfc3629#section-3
* Nice summary of the advantages of UTF-8 compared to other Unicode encodings: https://research.swtch.com/utf8
