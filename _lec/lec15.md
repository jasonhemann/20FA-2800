---
title: Measures, Actually
date: 2020-10-15
---

# Proposals in; met with most groups; 

If you have not met with me, or scheduled a meeting with me, then let's do it! 

### Don't wait to start again. 
### Don't wait until you're doomed. 

# Let's check on our reading! How's this going?

`PollEverywhere`

# Let's Recap

## No Decision procedures for termination
  
  One can't write an algorithm for checking this. (Really exciting result) 

  We need a bouncer at the door. ACL2 doesn't let us introduce
  functions willy-nilly. ACL2 saves us from accidentally allowing
  non-termination. Because that way is madness. 

## Admissible Definitions, Definition Principle 

### A definition is /admissible/ when ...

   1. `f` is a new function symbol (so that we aren't possibly adding
      an axiom about something that already exists) 
	  You can't add a new, 2nd meaning to `cdr`.
   2. The variables `x_i` in the definition of the body are unique
      (else, what happens when we subst in?)
   3. `body` is a term, possibly using `f` recursively as a function
      symbol, with no free variable occurrences other than the `x_i`
      The word "term", here means that it is a legal expression in the
      current history.
   4. This means that if you evaluate the function on any inputs that
	  satisfy the input contract, the function will terminate. A
	  *total*, computable function. Terminates on (acceptable) input.

   5. `ic ⇒ oc` is a theorem. (note this is just describing the *contracts*.

   6. If the `ic` holds, all the body contracts hold too.

## /Contract Theorem/ for `f`: `ic => oc`

## /Definitional Axiom/ for `f`: `ic => (f x1 .. xn) = body`

## But termination!? Measure functions 101

   A /measure/ function is a function we write to *show*
   termination. The *metric* by which we evidence that the data over
   which the function operates decreases to a stopping point.
   
   If we can put our function's behavior in a 1:1 correspondence with
   a strictly decreasing sequence of natural numbers, then we'll know
   that our function terminates.
   
### The fine print: "measure" function `m`

   (Skip unless demanded by students)
 
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
# Today Lecture Contents

## Recap 

###  What if we try to use `len` as a measure for this?
   ```lisp	
   (definec f (x :tl) :tl
     (cons 'cat (f x)))
   ```
   What about some other?

   Substitution showing a counterexample `((x '(a b c)))`

### Why is m a /bad/ measure _here_? 

  ```lisp
  (definec app2 (x :tl y :tl) :tl
	  (declare (xargs :measure (m x y)))
	(if (endp x)
		y
	  (cons (first x) (app2 (rest x) y))))
  ```
  



# Watching it Execute

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

### For right now: additional arguments? `(declare (ignorable y))`

   BTW, you could use `(declare (ignorable y))` in your `case-match` clauses, too. 
   I prefer `&` as the better solution!

   We will improve on this later!

### How does it work when we try it out
  
  Notice that the measure has to be of the form `(if IC (m ...) 0)`, not
  `implies`, and `0` for the case the contracts don't hold.

  ```lisp
  (definec app2 (x :tl y :tl) :tl
	  (declare (xargs :measure (if (and (tlp y) (tlp x)) (m x y) 0)
                      :hints (("goal" :do-not-induct t)))) ;; means do not use induction in your termination proof
	(if (endp x)
		y
	  (cons (first x) (app2 (rest x) y))))
  ```

##  What if we mess up. 

```
(definec m (x :tl y :tl) :nat
  (len y))

(definec app2 (x :tl y :tl) :tl
  (declare (xargs :measure (if (and (tlp y) (tlp x)) (m x y) 0)
                  :hints (("goal" :do-not-induct t))))
  (if (endp x)
      y
    (cons (first x) (app2 (rest x) y))))
```

Now if you look at the definition of app2, the measure provided does
not work, so you'll notice that the definec fails. If you want to see
output from the failed proof attempt, look at the output generated and
submit the defun form, which should be this.

```
(DEFUN APP2 (X Y)
  (DECLARE (XARGS :GUARD (AND (TRUE-LISTP X) (TRUE-LISTP Y))
                  :VERIFY-GUARDS NIL
                  :NORMALIZE NIL
                  :HINTS (("goal" :DO-NOT-INDUCT T))
                  :MEASURE (IF (AND (TLP Y) (TLP X)) (M X Y) 0)))
  (MBE :LOGIC (IF (AND (TRUE-LISTP X) (TRUE-LISTP Y))
                  (IF (ENDP X)
                      Y (CONS (FIRST X) (APP2 (REST X) Y)))
                  (ACL2S-UNDEFINED 'APP2 (LIST X Y)))
       :EXEC (IF (ENDP X)
                 Y
                 (CONS (FIRST X) (APP2 (REST X) Y)))))
```

Now, you can see that the proof failed and you can fix the measure, by
using `(len x)` not `(len y)` and try again.

# Some folk walk us through proofs:

## No. 4, Lab

## No. 5, Lab

## No. 5. Homework

  
  
