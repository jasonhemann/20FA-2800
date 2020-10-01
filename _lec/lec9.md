---
title: 
date: 2020-09-30
---

# Where we last left. 
 
 (Generally)

# Quiz on PollE (on What?)

# Recap

 `(= (len (cons x y)) (len (cons z y)))`

## How do we get there. 

## Do the LHS

```lisp
(len (cons x z))
= { definition of len }
(if (consp (cons x z))
   (+ 1 (len (cdr (cons x (list z)))))
   0))
= { consp axioms }
(if t
   (+ 1 (len (cdr (cons x z))))
   0))
= { if axioms }
 	 (+ 1 (len (cdr (cons x z))))
= { cdr axioms }
   (+ 1 (len z))
```   

## Then what? 

### Two choices: 

  - RHS, do it again, or
  - LHS, as a lemma. Instantiate!
  
## Lemma. Prove once, use over and over. 
(Same status as a theorem, just POV.)

```lisp
(len (cons x z))
= { Lemma }
(+ 1 (len z))
= { Lemma with instantiation ((x y)) }
(len (cons y z))
```

# Equality

## Equality is a (trivial kind of) equivalence relation.

### An important, special kind of relationship.

Give me another equivalence relation. Tell me a set, and an
equivalence relation on that set. Go. 

E.g. NBA players and "teammate."

What's neat, and what you notice, is that you partition the set into blocks. 

## Equivalence relation:
   Reflexive, symmetric, and transitive. 
   These are axioms of equality (really any equivalence relation, by defn of one)

   We can use these whenever we want, instantiated.

## Equality axiom scheme for functions: 

For all x_1 ... x_n and y_1 ... y_n, if x_1 = y_1 and ... x_n = y_n, then
f(x_1 ... x_n) =  f(y_1 ... y_n)

## Built-in functions, built-in axioms.

Axioms for if:
x = nil => (if x y z) = z
x ≠ nil => (if x y z) = y

Axioms for car, cdr:
(car (cons x y)) = x
(cdr (cons x y)) = y

Axiom for consp:
(consp (cons x y)) = t

## Definitional axioms.

With every function /you/ define, you get some axioms.

### When we define a function we get the axioms:

   When we define a function 
   f :ic 
	 :oc 




   we get the axioms:
   IC   =>  ( (f x1 x2 …) = body )
   IC   =>   OC

### Example

(defunc mydiv (x y)
	:input-contract (and (intp x) (intp y) 
					(not (equal y 0)))
	:output-contract (rationalp (mydiv x y))
	(/ x y))

### Substitution. 

Important operation. 

## Our proofs, in detail:

Important to have a standardized format. 

### Machine checkable.

### Which is great! Definition of substitution wrong, for about ~20yrs

Hilbert, Ackermann... etc. 



### Proof Format

  ```
  Context: the list of our hypotheses
  Derived context: additional hypotheses that we can easily derive from the context
  Goal: what is left to prove
  Proof: the proof itself, typically in equational form
  ```

There are other parts to a proof that we will see later
Not all parts are mandatory, e.g., derived context is optional, and even context may be sometimes empty
We will see all these rules in detail as we go along


## Set-up a context. 

This is where if you see an implication, how you get there. Write down
all the things that we get to assume, and then show some equality
holds in that context. Here, using it both technical and non-technical.

"In this context." "In this situation" "When the state of the world is like this, then ..."


### Example Context:

   ```
   C1: (tlp x)
   C2: (tlp y)
   C3: (tlp z)
   C4: (endp x)
   Goal:  (aapp (aapp x y) z) = (aapp x (aapp y z))
   Proof:
   (aapp (aapp x y) z)
   = { def aapp }
   (aapp (if (endp x) y (cons (car x) (aapp (cdr x) y))) z)
   = { C4, if axioms }
   (aapp y z)
   = { C4, if axioms }
   (if (endp x) (aapp y z) 
		   (cons (car x) (aapp (cdr x) (aapp y z))))
   = { def aapp }
   (aapp x (aapp y z))
   ```

## Derived Contexts

  ```
  (
  (tlp x) & (tlp y) & (tlp z) & (consp x) &
  (aapp (aapp (cdr x) y) z) = (aapp (cdr x) (aapp y z))
  )
  =>
  (aapp (aapp x y) z) = (aapp x (aapp y z))
  ```
  
### Axiom: (tlp x) & (consp x) => (not (endp x))

Derived context are: Useful information you can get from known axioms
and the actual context, without having to involve the goal itself at
all.


## Claim 
(implies (consp x)
         (implies (and (tlp x) (tlp y))
                  (implies (endp x)
                           (equal (aapp x y) (rrev y)))))
  
