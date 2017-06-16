---
title: Thinking Clearly About Bytes and Text
---

* Text and bytes are different things
* **Text is encoded as bytes.**
* JSON has no bytes type
* The computer world has no text, and the human world has no bytes.
* When to encode and when to decode
* It's now best to think about ASCII as an encoding where every
  character fits perfectly into a single byte. But the range of
  supported characters is very limited.
* Notes on other encodings
  * UTF8 is variable length, so the length of a UTF8 encoded string is
    >= the number of characters.
* Just using Python 3 doesn't get you out of having to think this way
  * Python 3 simply changes quoted literals to be text instead of bytes
  * Sidenote: this is a strange assumption. It assumes that a human
    (text) will always be involved during the course of the program's
    execution. While very common for websites, there are millions of
    simple but important programs where people are never involved. If
    it's just computers working directly with bytes is more than
    acceptable. The other argument is that text literals make Python a
    better teaching language, but as this post demonstrates, thinking
    clearly about bytes and text is not hard and be taught as early as
    possible. Avoiding it only assumes the worst of future generations
    of programmers.
