---
title: 
date: 2020-10-01
---

# Where we last left. 
 
 (Generally)

## Lemmas
 - Prove once, use over and over. 
 - We used implicitly symmetry of equality, in reverse!, in using it. 
## Equality, equivalence relatinos
## Axioms
 - Equality axioms
 - Equality axiom scheme for functions
## built-in axioms for built-in functions
 - Axioms for if:
 - Axioms for car, cdr:
 - Axiom for consp:
## Definitional axioms.
   IC   =>  ( (f x1 x2 …) = body )
   IC   =>   OC

# Example

(defunc recip (x)
  :ic (and (rationalp x) (not (zip x)))
  :oc (rationalp (recip x))
  (/ x))
  
# What contracts do we get from accepting this definition?

# Today's topics

## On the computational nature of conjectures, 
## using ACL2s to understand conjectures and counterexamples, 
## equational reasoning with nested Boolean operators

## Our proofs, in detail:

### Proof of what? Start w/a claim


```lisp
(implies (consp x)
         (implies (and (tlp x) (tlp y))
                  (implies (endp x)
                           (equal (aapp x y) (rrev y)))))
```  


### Proof Format

  ```
  Context: the list of our hypotheses
  Derived context: additional hypotheses that we can easily derive from the context
  Goal: what is left to prove
  Proof: the proof itself, (typically) in equational form
  ```

There are other parts to a proof that we will see later
Not all parts are mandatory, e.g., derived context is optional, and even context may be sometimes empty
We will see all these rules in detail as we go along


## Set-up a context. 

### Exportation is one of the things we will do.

This is where if you see an implication, how you get there. Write down
all the things that we get to assume, and then show some equality
holds in that /context/. Here, using it both technical and
non-technical.

Setting up a context is listing the premises. The obvious ones. No
need to try and enumerate an infinite set.

"In this context." "In this situation" "When the state of the world is like this, then ..."

### We may also do some other boolean simplifications. Tautologically equivalent

#### E.g. `A ^ !C => !B` to `A ^ B => C` 

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

Derived context are useful information you can get from the actual
context and known axioms (e.g. function definitions)

Without yet involve the goal itself at all.
  
### Axiom: 

D1. (tlp (rest x)) { Def tlp, C1, C3 }
D2. (in a (rest x)) { Def in, C6, C3, C4, PL }
D3. (in a (app (rest x) y)) { C5, D1, D2, MP }

Important to have a standardized format. 

### Machine checkable.

### Which is great! Definition of substitution wrong, for about ~20yrs

Hilbert, Ackermann... etc. 

## Substitution. 

Important operation. 
