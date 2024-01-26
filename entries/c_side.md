---
title: Python by the C side
---

*Note: This will be my last post on the PayPal Engineering blog. If
 you've enjoyed
 [this sort of content](https://medium.com/paypal-tech/search?q=python)
 subscribe to
 [my blog](http://sedimental.org)/[pythondoeswhat.com](http://pythondoeswhat.com/)
 or [follow me on Twitter](https://twitter.com/mhashemi). It's been
 fun!*

All the world is legacy code, and there is always another, lower layer
to peel away. These realities cause developers around the world to go
on regular pilgrimage, from the terra firma of Python to the coasts of
C. From [zlib](http://www.zlib.net/) to
[SQLite](https://www.sqlite.org/about.html) to
[OpenSSL](https://www.openssl.org/), whether pursuing speed,
efficiency, or features, the waters are powerful, but often
choppy. The good news is, when you’re writing Python, C interactions
can be a day at the beach.

# A brief history

As the name suggests, [CPython][cpython], the primary implementation of Python
used by millions, is written in C. Python core developers embraced and
exposed Python’s strong C roots, taking a traditional tack on
portability, contrasting with the “write once, debug everywhere”
approach popularized elsewhere. The community followed suit with the
core developers, developing several methods for linking to C. Years of
these interactions have made Python a wonderful environment for
interfacing with operating systems, data processing libraries, and
everything the C world has to offer.

[cpython]: https://en.wikipedia.org/wiki/CPython

This has given us
[a lot of choices](https://wiki.python.org/moin/IntegratingPythonWithOtherLanguages),
and we’ve tried all of the standouts:

<table style="height: 519px;" width="100%">
<thead>
<tr>
<th>Approach</th>
<th>Vintage</th>
<th>Representative user</th>
<th>Notable Pros</th>
<th>Notable Cons</th>
</tr>
</thead>

<tbody>
<tr>
<td><a href="https://docs.python.org/2/extending/extending.html">C extension modules</a></td>
<td>1991</td>
<td>Standard library</td>
<td><a href="https://docs.python.org/2/c-api/">Extensive documentation</a> and tutorials. Total control.</td>
<td>Compilation, portability, reference management. High C knowledge.</td>
</tr>

<tr>
<td><a href="http://www.swig.org/Doc1.3/Python.html">SWIG</a></td>
<td>1996</td>
<td><a href="http://www.chokkan.org/software/crfsuite/">crfsuite</a></td>
<td>Generate bindings for many languages at once</td>
<td>Excessive overhead if Python is the only target.</td>
</tr>

<tr>
<td><a href="https://docs.python.org/2/library/ctypes.html">ctypes</a></td>
<td>2003</td>
<td><a href="https://github.com/wbond/oscrypto">oscrypto</a></td>
<td>No compilation, wide availability</td>
<td>Accessing and mutating C structures cumbersome and error prone.</td>
</tr>

<tr>
<td><a href="http://cython.org/">Cython</a></td>
<td>2007</td>
<td><a href="http://www.gevent.org/">gevent</a>, <a href="https://kivy.org/">kivy</a></td>
<td>Python-like. Highly mature. High performance.</td>
<td>Compilation, new syntax and toolchain.</td>
</tr>

<tr>
<td><a href="https://cffi.readthedocs.io/en/latest/overview.html">cffi</a></td>
<td>2013</td>
<td><a href="https://cryptography.io/en/latest/">cryptography</a>, <a href="http://pypy.org/">pypy</a></td>
<td>Ease of integration, PyPy compatibility</td>
<td>New/High-velocity.</td>
</tr>

</tbody>
</table>

There’s a lot of history and detail that doesn’t fit into a table, but every option falls into one of three categories:

1.  **[Writing C](#writing_c)**
2.  **[Writing code that translates to C](#translating_to_c)**
3.  **[Writing code that calls into libraries that present a C interface](#calling_into_c)**

Each has its merits, so let’s explore each category, and then we’ll finish with a real, live, worked example at the end!

# Writing C

Python’s core developers did it and so can you. Writing C extensions
to Python gives an interface that fits like a glove, but also requires
knowing, writing, building, and debugging C. The bugs are much more
severe, too, as
[a segmentation fault](https://en.wikipedia.org/wiki/Segmentation_fault)
that kills the whole process is much worse than a Python exception,
especially in
[an asynchronous environment](https://medium.com/paypal-tech/introducing-support-98945f023a8e)
with hundreds of requests being handled within the same process. Not
to mention that the glove is also tailored to CPython, and won’t fit
quite right, or at all, in other execution environments.

At PayPal, we’ve used C extensions to speed up our service
serialization. And while we’ve solved the build and portability issue,
we've lost track of our share of references and have moved on from
writing straight C extensions for new code.

# Translating to C

After years of writing C, certain developers decide that they can do
better. Some of them are certainly onto something.

## Going Cythonic

[Cython][cython] is a superset of the Python programming language that
has been turning type-annotated Python into C extensions for nearly a
decade, longer if you count its predecessor, Pyrex. Apart from its
maturity, the points that matters to us are:

* Every Python file is a valid Cython file, enabling incremental,
  iterative optimization
* The generated C is highly portable, building on Windows, Mac, and
  Linux
* It’s common practice to check in the generated C, meaning that
  builders don’t need to have Cython installed.

Not to mention that the generated C often makes use of performance
tricks that are too tedious or arcane to write by hand, partially
motivated by scientific computing’s constant push. And through all
that, Cython code maintains a high level of integration with Python
itself,
[right down to the stack trace and line numbers](https://twitter.com/mhashemi/status/710592370333450240).

PayPal has certainly benefitted from their efforts through
high-performance Cython users like [gevent][gevent], [lxml][lxml], and
[NumPy][numpy]. While our first go with Cython didn’t stick in 2011,
since 2015, all native extensions have been written and
rewritten to use Cython. It wasn’t always this way however.

[cython]: http://cython.org/
[gevent]: http://www.gevent.org/
[lxml]: http://lxml.de/
[numpy]: http://www.numpy.org/


## A sip, not a SWIG

An early contributor to Python at PayPal got us started using
[SWIG][swig], the Simplified Wrapper and Interface Generator, to wrap
PayPal C++ infrastructure. It served its purpose for a while, but
every modification was a slog compared to more Pythonic techniques. It
wasn’t long before we decided it wasn’t our cup of tea.

Long ago SWIG may have rivaled extension modules as Python
programmers’ method of choice. These days it seems to suit the needs
of C library developers looking for a fast and easy way to wrap their
C bindings for multiple languages. It also says something that
searching for SWIG usage in Python nets as much SWIG replacement
libraries as SWIG usage itself.

[swig]: http://www.swig.org/

# Calling into C

So far all our examples have involved extra build steps, portability
concerns, and quite a bit of writing languages other than Python. Now
we’ll dig into some approaches that more closely match Python’s own
[dynamic nature](https://en.wikipedia.org/wiki/Dynamic_programming_language):
ctypes and cffi.

Both ctypes and cffi leverage C’s Foreign Function Interface (FFI), a
sort of low-level API that declares callable entrypoints to compiled
artifacts like shared objects (.so files) on Linux/FreeBSD/etc. and
dynamic-link libraries (.dll files) on Windows. Shared objects take a
bit more work to call, so ctypes and cffi both use libffi, a C library
that enables dynamic calls into other C libraries.

Shared libraries in C have some gaps that libffi helps fill. A Linux
.so, Windows .dll, or OS X .dylib is only going to provide symbols: a
mapping from names to memory locations, usually function
pointers. [Dynamic linkers](https://en.wikipedia.org/wiki/Dynamic_linker)
do not provide any information about how to use these memory
locations. When dynamically linking shared libraries to C code, header
files provide the function signatures; as long as the shared library
and application are
[ABI compatible](https://en.wikipedia.org/wiki/Application_binary_interface),
everything works fine. The ABI is defined by the C compiler, and is
usually
[carefully managed](https://gcc.gnu.org/onlinedocs/libstdc++/manual/abi.html)
so as not to change too often.

However, Python is not a C compiler, so it has no way to properly call
into C even with a known memory location and function signature. This
is where libffi comes in. If symbols define _where_ to call the API,
and header files define _what_ API to call, libffi translates these
two pieces of information into _how_ to call the API. Even so, we
still need a layer above libffi that translates native Python types to
C and vice versa, among other tasks.

## ctypes

[ctypes][ctypes] is an early and Pythonic approach to FFI
interactions, most notable for its inclusion in the Python standard
library.

[ctypes]: https://docs.python.org/2/library/ctypes.html

ctypes works, it works well, and it works across CPython, PyPy,
Jython, IronPython, and most any Python runtime worth its salt. Using
ctypes, you can access C APIs from pure Python with no external
dependencies. This makes it great for scratching that quick C itch,
like
[a Windows API that hasn’t been exposed in the os module][win_boltons].
If you have an otherwise small module that just needs to access one or
two C functions, ctypes allows you to do so without adding a
heavyweight dependency.

[win_boltons]: https://github.com/mahmoud/boltons/blob/01fb908d252b6fc5e72fe876a0eebaee65b200df/boltons/fileutils.py#L239

For a while, PayPal Python code used ctypes after moving off of
SWIG. We found it easier to call into vanilla shared objects built
from C++ with an
[extern C](http://www.tldp.org/HOWTO/C++-dlopen/thesolution.html)
rather than deal with the SWIG toolchain. ctypes is still used
incidentally throughout the code for exactly this: unobtrusively
calling into certain shared objects that are widely deployed. A great
open-source example of this use case is
[oscrypto](https://github.com/wbond/oscrypto), which does exactly this
for secure networking. That said, ctypes is not ideal for huge
libraries or libraries that change often. Porting signatures from
headers to Python code is tedious and error-prone.

## cffi

[cffi][cffi], our most modern approach to C integration, comes out of
the PyPy project. They were seeking an approach that would lend itself
to the optimization potential of PyPy, and they ended up creating a
library that fixes many of the pains of ctypes. Rather than
handcrafting Python representations of the function signatures, you
simply load or paste them in from C header files.

For all its convenience, cffi’s approach has
[its limits](https://cffi.readthedocs.io/en/latest/cdef.html#ffi-cdef-limitations). C
is really almost two languages, taking into account
[preprocessor macros][macros]. A macro performs string replacement,
which opens a Fun World of Possibilities, as straightforward or as
complicated as you can imagine. cffi’s approach is limited around
these macros, so applicability will depend on the library with which
you are integrating.

On the plus side, cffi does achieve its stated goal of outperforming
ctypes under PyPy, while remaining comparable to ctypes under
CPython. The project is still quite young, and we are excited to see
where it goes next.

[cffi]: https://cffi.readthedocs.io/en/latest/
[macros]: https://gcc.gnu.org/onlinedocs/cpp/Macros.html

# A Tale of 3 Integrations: PKCS11

We promised an example, and we almost made it three.

PKCS11 is a cryptography standard for interacting with many hardware
and software security systems. The
[200-plus-page core specification](https://www.emc.com/emc-plus/rsa-labs/standards-initiatives/pkcs-11-cryptographic-token-interface-standard.htm)
includes many things, including the official client interface: A large
set of C header-style information. There are a variety of pre-existing
bindings, but each device has its own vendor-specific quirks, so what
are we waiting for?

## Metaprogramming

As stated earlier, ctypes is not great for sprawling interfaces. The
drudgery of converting function signatures invites transcription
bugs. We
[somewhat automated it](https://gist.github.com/kurtbrose/76a788f608511dd3d94089b0c89c328a),
but the approach was far from perfect.

Our second approach, using cffi, worked well for our first version’s
supported feature subset, but unfortunately PKCS11 uses its own
`CK_DECLARE_FUNCTION` macro instead of regular C syntax for defining
functions.  Therefore, cffi’s approach of skipping #define macros will
result in syntactically invalid C code that cannot be parsed. On the
other hand, there are other macro symbols which are compiler or
operating system intrinsics (e.g. `__cplusplus`, `_WIN32`,
`__linux__`). So even if cffi attempted to evaluate every macro, we
would immediately runs into problems.

So in short, we’re faced with a hard problem. The PKCS11 standard is a
gnarly piece of C. In particular:

1.  Many hundreds of important constant values are created with #define
2.  Macros are defined, then re-defined to something different later on in the same file
3.  pkcs11f.h is included multiple times, even once as the body of a struct

In the end, the solution that worked best was to write up a rigorous
parser for the particular conventions used by the slow-moving
standard, generate Cython, which generates C, which finally gives us
access to the complete client, with the added performance bonus in
certain cases. Biting this bullet took all of a day and a half, we’ve
been very satisfied with the result, and it's all thanks to a special
trick up our sleeves.

## Parsing Expression Grammars

[Parsing expression grammars](https://en.wikipedia.org/wiki/Parsing_expression_grammar)
(PEGs) combine the power of a true parser generating an abstract
syntax tree, not unlike
[the one used for Python itself](https://docs.python.org/2/library/ast.html),
all with the convenience of regular expressions. One might think of
PEGs as recursive regular expressions. There are several good
libraries for Python, including
[parsimonious](https://github.com/erikrose/parsimonious) and
[parsley](https://github.com/python-parsley/parsley/). We went with
the former for its simplicity.

For this application, we defined a two grammars, one for pkcs11f.h and
one for pkcs11t.h:

```
PKCS11F GRAMMAR

    file = ( comment / func / " " )*
    func = func_hdr func_args
    func_hdr = "CK_PKCS11_FUNCTION_INFO(" name ")"
    func_args = arg_hdr " (" arg* " ); #endif"
    arg_hdr = " #ifdef CK_NEED_ARG_LIST" (" " comment)?
    arg = " " type " " name ","? " " comment
    name = identifier
    type = identifier
    identifier = ~"[A-Z_][A-Z0-9_]*"i
    comment = ~"(/\*.*?\*/)"ms

PKCS11T GRAMMAR

    file = ( comment / define / typedef / struct_typedef / func_typedef / struct_alias_typedef / ignore )*
    typedef = " typedef" type identifier ";"
    struct_typedef = " typedef struct" identifier " "? "{" (comment / member)* " }" identifier ";"
    struct_alias_typedef = " typedef struct" identifier " CK_PTR"? identifier ";"
    func_typedef = " typedef CK_CALLBACK_FUNCTION(CK_RV," identifier ")(" (identifier identifier ","? comment?)* " );"    member = identifier identifier array_size? ";" comment?
    array_size = "[" ~"[0-9]"+ "]"
    define = "#define" identifier (hexval / decval / " (~0UL)" / identifier / ~" \([A-Z_]*\|0x[0-9]{8}\)" )
    hexval = ~" 0x[A-F0-9]{8}"i
    decval = ~" [0-9]+"
    type = " unsigned char" / " unsigned long int" / " long int" / (identifier " CK_PTR") / identifier
    identifier = " "? ~"[A-Z_][A-Z0-9_]*"i
    comment = " "? ~"(/\*.*?\*/)"ms
    ignore = ( " #ifndef" identifier ) / " #endif" / " "

```

Short, but dense, in true grammatical style. Looking at
[the whole program](https://gist.github.com/kurtbrose/7f2d9b3d0f3eb7c15c197f13d4335dbf),
it’s a straightforward process:

1.  Apply the grammars to the header files to get our abstract syntax tree.
2.  Walks the AST and sift out the semantically important pieces, function signatures in our case.
3.  Generate code from the function signature data structures.

Using only 200 lines of code to bring such a massive standard to bear,
along with the portability and performance of Cython, through the
power of PEGs ranks as one of the high points of Python in practice at
PayPal.

# Wrapping up

It’s been a long journey, but we stayed afloat and we’re happy to have
made it. To recap:

*   Python and C are hand-in-glove made for one another.
*   Different C integration techniques have their applications, our stances are:
    *   ctypes for dynamic calls to small, stable interfaces
    *   cffi for dynamic calls to larger interfaces, especially when targeting PyPy
    *   Old-fashioned C extensions if you’re already good at them
    *   Cython-based C extensions for the rest
    *   SWIG pretty much never
*   Parsing Expression Grammars are great!

All of this encapsulates perfectly why we love Python so much. Python
is a great starter language, but it also has serious chops as a
systems language and ecosystem. That bottom-to-top, rags-to-riches,
books-to-bits story is what makes it the ineffable, incomparable
language that it is.

C you around!

[Kurt](https://github.com/kurtbrose) and [Mahmoud](https://github.com/mahmoud)
