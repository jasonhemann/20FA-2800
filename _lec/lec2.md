---
title: A first dose of ACL2
date: 2020-09-10
---


- [lec2.lisp]({{ site.baseurl }}/assets/code/lec2.lisp)
- [lec2.lisp.a2s]({{ site.baseurl }}/assets/code/lec2.lisp.a2s)

# Topics 

  - [Lisp v. Racket](#lisp-v-racket)
  - The ACL2s Environment
  - data, datatypes, and functions
  
# "All the Lisp you need to know"

## Lisp History

  - McCarthy. 
  - Wasn't intended as a PL (happens in a couple places!)
  - (One of) the oldest languages.
  - "ACL2" - A Computational Logic for Applicative Common Lisp
  -  ACL2 Lisp is a language with history.  Poor conventions so some
     of the things aren't as first principles (`car`, `cdr`)
  - e.g. "... of Lisp on the IBM 704." Obviously. ಠ_ಠ

# The Universe 

(The stuff about which we can write ACL2 programs.)

We'll say "All" when we allow anything in the universe.

Including: 

- rationals 
- symbols
- chars
- strings
- conses

# Lisp v. *SL

- `cons` arbitrary binary trees vs. tl. (`cons`tructor)
- how to read, expand the tl into full bt.

One of the things we can talk about are programs *in* the language.

Expressions are things you can evaluate. Some expressions are
self-evaluating.

# Two built-in functions: 

## `if` 

What's the signature of `if`? 

### Not every list beginning w/ `(if ...)`  is an expression!

#### !! Not Racket!

   ```lisp 
   (if '() b c)
   ```

## `(equal a b)` 

# Functions

Not `define` the way you did. 

`defunc` short-hand version

```lisp
:input-contract ...
:output-contract ...
```

# All functions must terminate! (You gotta make'em!)

`countdown`, fails to terminate. Contracts!

# Primitive types and predicates

The primitive types include: 

- rational,
- nat,
- integer,
- and pos

whose recognizers are
- rationalp,
- natp,
- integerp,
- and posp,

# Defining datatypes 

## `defdata`

### Union types 

`(defdata fullname (list string string))`

Union types let us take the union of existing types. E.g.,

`(defdata intstr (oneof integer string))`

## Recursive type expressions 

Recursive type expressions involve the `oneof` combinator (noun: a
thing that combines. Like "regulators" regulate) and product
combinations, where additionally there is a (potentially-recursive)
reference to the type being defined.

`(defdata loi (listof integer))`

This defines the type consisting of lists of integers.

For example,here is another way of defining a list of integers.

`(defdata loi (oneof nil (cons integer loi)))`
