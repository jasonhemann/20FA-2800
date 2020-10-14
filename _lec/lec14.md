---
title: Definition and Termination
date: 2020-10-14
---

# Welcome Back!

## Hope everyone is well and rested.

## Proposals coming due today.

If you have not met with me, or scheduled a meeting with me, then let's do it! 

### Let's check on our reading! How's this going?

`PollEverywhere`

# Definition Principle

We already understood this. Right? We had for every accepted
definition the axioms that `ic => oc` and `ic => (equal (f x) = body)`

But we know and we've seen that `definec` is a shallow wrapper over
`defunc`, and since not every predicate has a corresponding datatype,
we could go great with that. 

## There are many complications 

### Function bodies that return nil allow nil.

`(definec foo (x :all) :all (equal 0 1))`

### (Some) non-terminating functions let us derive nil

`(definec foo (x :all) :all (1- (f x)))`

(cf. `(definec foo (x :all) :all (f (1- x)))`)

### Non-terminating functions let us derive nil.

`(definec foo (x :all) :all y)`

### Functions with free variable occurrences let us derive nil. 

`(definec foo (x :all) :all y)`	

## Admissible definitions

So we need a bouncer at the door. ACL2 doesn't let us introduce
functions willy-nilly. ACL2 saves us from accidentally allowing
non-termination.

### Decision procedures for termination? No!

  - Almost all programs you write, you *want* to terminate
  - Non-terminating programs are almost always a bug
  
  So we would expect something to check that for us. 
  
  But you can't write an algorithm for this. 
  
  (I'll show you that later. Really exciting result) 
  
### A definition is /admissible/ when

   1. `f` is a new function symbol (so that we aren't possibly adding
      an axiom about something that already exists) 
	  You can't add a new, 2nd meaning to `cdr`.
   2. The variables `x_i` in the definition of the body are unique (else, what happens when we subst in?)
   3. `body` is a term, possibly using `f` recursively as a function symbol, with no free variable occurrences other than the `x_i` 
      The word "term", here means that it is a legal expression in the current history.
   4. This means that if you evaluate the function on any inputs that
   satisfy the input contract, the function will terminate. A *total*,
   computable function. Terminates on (acceptable) input.
  
  5. `ic ⇒ oc` is a theorem. (note this is just describing the *contracts*.
  
  6. If the `ic` holds, all the body contracts hold too.
  

### We have seen what we get as a result

   - /Contract Theorem/ for `f`: `ic => oc`
   - /Definitional Axiom/ for `f`: `ic => (f x1 .. xn) = body`

## But! How to prove termination?

  We *can't* prove termination with a general decision procedure. So
  it sounds like we are in trouble, and we cannot define
  functions. Yet, we have done so. What shall we do? 
  
## Our way: Measure functions 101

   A /measure/ function is a function we write to *show*
   termination. Because if we can put our function's behavior in a 1:1
   correspondence with a strictly decreasing sequence of natural
   numbers, then we'll know that our function terminates.
   
### The fine print: "measure" function `m`
 
   - an admissible function
   - defined over the parameters of the function `f` (the one we're really interested in)
   - with the same input contract as `f` (so, the same domain)
   - but outputs a natural number, and 
   - on every recursive call of `f` in `f`'s body, `m` applied to the
     arguments to that recursive call in the body returns a smaller
     number than m applied to the initial arguments to x, under the
     conditions that led to the recursive call. 
	 
   ```lisp
   (definec app2 (x :tl y :tl) :tl
	 (if (endp x)
		 y
	   (cons (first x) (app2 (rest x) y))))
   ```

#### Caveats 1: additional arguments? 

	```lisp
	(definec m (x :tl y :tl) :nat
	  (declare (ignorable y))
	  (len x))
	```

    BTW, you could use `(declare (ignorable y))` in your `case-match` clauses, too. 
	I prefer `&` as the better solution!

   We will improve on this later! 

### The proof! 

	```lisp 
	(implies (and (tlp x)
			 (tlp y)
			 (not (endp x)))
	  (< (len (rest x)) (len x)))
	```
	
###	Wait, what about `len`? 
	
#### We have an axiom that `cons-size` (cons-cell-count) is admissible, so terminating.

   ```(definec cons-size (x :all) :nat
        (if (consp x)
		    (+ 1 (cons-size (car x)) (cons-size (cdr x)))
		  0))
   ```

   ```lisp	
   (definec f (x :tl) :tl
     (cons 'cat (f x)))
   ```
   
   What would happen if we try to use a measure function like `len`
   for this?
   
   
### How does it work when we try it out

```lisp
(set-termination-method :measure)
(set-well-founded-relation n<)
(set-defunc-typed-undef nil)
(set-defunc-generalize-contract-thm nil)
(set-gag-mode nil)
```

ACL2s will complain about the definition of your measure function
unless you tell it to ignore arguments you don't use. (It is simpler
to tell it all arguments can be ignored via `(set-ignore-ok t)`.


   ````lisp 
   (definec m (x :tl y :tl) :nat
	 (declare (ignorable y)
	 (len x))
   ```
  
  Notice that the measure has to be of the form `(if IC (m ...) 0)`, not
  `implies`, and `0` for the case the contracts don't hold.

  ```lisp
  (definec app2 (x :tl y :tl) :tl
	(declare (xargs :measure (if (and (tlp y) (tlp x)) (m x y) 0)))
	(if (endp x)
		y
	  (cons (first x) (app2 (rest x) y))))
  ```

   
   

  
  
