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



  
  
