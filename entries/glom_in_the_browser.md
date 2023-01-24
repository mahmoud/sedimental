---
tilte: Glom in the browser
---

A few months ago, during parental leave, I started work on a project I'd had on my mind for the last couple years.
I'd been following Svelte since 2019 and wanted to see how far it had come. I knew I'd miss Python, but before long, I realized I could have my cake and eat it, too. Thanks to PyScript.

PyScript is very new, having been publicly released in mid-2022. 
It's based on a similarly-new project, Pyodide, which is an emscripten-built CPython. 
As we'll get into, I realized this was a nontrivial proposal.
Could I depend of this Svelte/TypeScript/PyScript arrangement?
I decided to build a prototype app to experiment and learn about the stack.
Today that app is live.
This is the launch, and this talk is about the findings, and journey.

# The beginning

It all started in 2018. I was building a Django web app and REST API. 
I was manipulating a lot of large, unwieldy objects, and I was worried I was going to break the site when I hit some unforeseen corner case.

Worse, the work was rote. 
Necessary, but tedious.
Update an API endpoint, update a template, add an API endpoint, update a template. 
Switching back and forth between templates and API endpoints: a spark.
What if there was some way to template data into different data? 
Not XSLT or JSONPath, but a Pythonic way?
In a spat of productive procrastination, glom was born.

# The glom value prop

* Smaller, better code and fewer, better errors
* Examples

# The glom friction

* Density
* Context switching
* Learning curve

Like regex (or any other embedded sublanguage, Django, Jinja, f-strings)

# The solution

Python owes a large part of its success to the humble REPL. 
Read-Evaluate-Print-Loop. 
That inspiration led directly to IPython and the IPython Notebook, now known as Jupyter.
Changed the game for how we write code.

*Low barrier to entry*

Easy to try something out, iterate quickly.
See also: CodeSandbox, JSFiddle, Regex101, Compiler Explorer.

# Feature tour

* PYTHON EXECUTION
* Shareable URL
* Dark mode (P0 for a dev tool)
* Black autoformatting
* Clipboard
* Examples

# Learnings

## The good

* It works
  * Svelte/TypeScript/Python hybrid
  * It's not even that slow in prod (~5s to active)
  * Building and developing is tight, kudos to rollup and vite
* It's way more fun than React

## The bad

* Playwright is pretty slow.
  * Firefox is the odd one out
  * Selenium might be faster
* Only supports wheels
* PyScript docs have a good meta structure, but uneven quality

## The ugly

* PyScript was easy to get started, but using Pyodide directly is looking like the better investment if you care about control. Feels like a bit of a demo vehicle.
* Svelte stores are great, but a bit too basic. For debugging, I found myself missing Redux. There are a wide variety of alternative stores worth looking into.
* CodeMirror 6 is way more complex than earlier versions. Powerful, but hard to find examples that do exactly what you want. Probably worth it, but be ready.
  * Annoyingly PyScript chose the exact same tools I did?? Svelte and CodeMirror power the REPL and other components. This led to some very confusing errors that I thought were coming from my bugs, but were actually PyScript breakages.
* It's still frontend. You've got to be 2-3x as careful when you upgrade libraries.

## The lucky

* I wrote a build wrapper script, this ended up saving me when it came to Sentry integration
* Sentry itself. Feel much more confident with mostly manual testing, slapping sentry on it, and fixing whatever comes up
* Dev tool, so I don't need to hide the debug mode

# Code tour

* Very... organic

# Future features

* Offline mode
* Embedding
* Autocompletion