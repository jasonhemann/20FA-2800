---
title: The Trinity
date: 2020-10-28
---

# PollE Q to start w/

# Fib example: to start w/
```lisp
(definec fib (n :nat) :nat
  (cond
   ((< n 2) n)
   (t (+ (fib (1- n)) (fib (1- (1- n)))))))
```

## To what induction scheme does `fib` give rise?
```lisp
;; 
(not (natp n)) -> \phi

(and (natp n) (< n 2)) -> \phi

(and (natp n) (not (< n 2))
     \phi|((n (- n 1)))
     \phi|((n (- n 2)))
     )
```	 

## Let's (for the moment!) use the ind. scheme for `len`
```lisp
;; ((\phi (natp (fib n))))

(not (natp n)) -> (natp (fib n))

(and (natp n) (< n 2)) -> (natp (fib n))

(and (natp n) (not (< n 2)) (natp (fib (- n 1)))) -> (natp (fib n))

;; Conjecture
(implies (and (natp n) (not (< n 2)) (natp (fib (- n 1))))
	 (natp (fib n)))

;; Contract Completion
(implies (and (natp n)
	      (natp (- n 1))
	      (not (< n 2))
	      (natp (fib (- n 1))))
	 (natp (fib n)))

;; Context
C1 (natp n)
C2 (natp (- n 1))
C3 (not (< n 2))
C4 (natp (fib (- n 1)))

;; Derived Context
D1 (<= 2 n) {C3}

;; Goal
(natp (fib n))

;; Proof
(natp (fib n))
= {Def fib}
(natp
 (cond
  ((< n 2) n)
  (t (+ (fib (1- n)) (fib (1- (1- n)))))))
= {EQR}
(natp (+ (fib (1- n)) (fib (1- (1- n)))))
= {Arith}
(and (natp (fib (1- n))) (natp (fib (1- (1- n)))))
= {C4}
(and t (natp (fib (1- (1- n)))))
= {Taut}
(natp (fib (1- (1- n))))
= {Def fib}
(natp
 (cond
  ((< (- n 2) 2) (- n 2))
  (t (+ (fib (- n 3)) (fib (- n 4))))))

;; ಠ_ಠ
```

## What went wrong?

The shape of the data did not guide the shape of the program!! 

Well, because we didn’t define `fib` using the `Nat` data definition,
so why should the data definition give rise to the induction scheme we
need?

# The shape of the data guides the shape of the program

	"The structure of a program must be based on the structures of all of
	the data it processes." --- Michael Jackson, Structured Programming, 1975

## Why was this drilled from F1? 

  Because of truths from Logic and Comp! This is not something that
  @NEU invented or someone's hobby-horse. This is revealing something.

## Elsewhere else-ways

	"There are certain close analogies between the methods used for
	structuring data and the methods for structuring a program which
	processes that data." -- Hoare, Notes on Structured Programming, 1972

	"Show me your flowcharts and conceal your tables, and I shall continue
	to be mystified. Show me your tables, and I won’t usually need your
	flowcharts; theyll be obvious." --- Brooks, The Mythical Man-Month, 1975 
		
	"Show me your code and conceal your data structures, and I shall
	continue to be mystified. Show me your data structures, and I won’t
	usually need your code; it’ll be obvious." --- Raymond, The Cathedral
	and the Bazaar, 1999

	"The central theme of this book has been the relationship between data
	and program structures. The data provides a model of the problem
	environment, and by basing our program structures on data structures
	we ensure that our programs will be intelligible and easy to
	maintain." --- Michael Jackson, Structured Programming, 1975

# How do we follow the structure of our data? 

## What induction scheme do we get for data definitions? 

Use the definition of the recognizer that `defdata` generates to
determine the induction scheme.

## Try another one

   ```lisp
   (defdata n (oneof '(Z) (cons 'S n)))
   ```

### What do elements of this datatype look like?

   ```lisp
   (Z)
   (S Z)
   (S S S S Z)
   ```

### If ACL2 admits `n` automagically get np (the predicate. The recognizer.)

Arabic numerals aren't structurally recursive in the same way!

### Playground arithmetic, dartboard arithmetic, is!


   ````
   Me    You
   |||    ||||
   ````

## Step back and look.

  Every admissible recursive definition leads to a valid induction scheme.

  What underlies both recursion and induction is _termination_.

  So, terminating functions give us both recursion schemes and induction schemes.

## The data-function-induction (DFI)trinity:

### 1. Data definitions give rise to predicates recognizing such definitions. (recognizers)

   We must have a proof that these predicates  terminate. (Otherwise they are inadmissible by theDefinitionalPrinciple.) 

   These predicates' bodies give rise to a recursion scheme, e.g.,
   `tlp` gives rise to the common recursion scheme for iterating over
   a list.
  
### 2.Functions over these data types are defined by using the recursion scheme as a template.

   !! (The function template from F1!!!)

   Templates allow us to define correct functions by assuming that the functionwe are defining works correctly in the recursive case.

### 3.The Induction Principle: 

  Proofs by induction involving such data definitions and functions
  over them should use the same recursion scheme to generate /proof
  obligations/. Proof obligations are the inductive cases of an
  induction scheme turned inside out.

	A & B -> C
	ORRR
	C <- if A and B

### Recursion-induction connection

   Notice also that induction and recursionare tightly related
   (Induction is recursion inside-out)
   
   - when defining recursive functions, we get to assume that the
     function works on smaller inputs

   - when proving theorems with induction, we get to assume that the
     theorem holds on smaller inputs

### Both straightforwardly extend the code/equational reasoning

   For each recursive case, we assume the theorem under any
   substitutions that map the formals to arguments in that recursive
   call. This is about as simple an extension to straight-line code as
   we can imagine.

  Recursion provides us with a significant increase in expressive
  power, allowing us to define functions that are not expressible
  using only straight-line code.

  Non-recursive cases are proven directly.

  Induction provides us with a significant increase in theorem proving
  power over equational reasoning, analogous to the increase in
  definitional power weget when we move from straight-line code to
  recursive code.

