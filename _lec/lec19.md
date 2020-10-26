---
title: Induction, Proving Properties w/
date: 2020-10-26
---

# HW Setup Q

## How do I deal with a `cond` w/cases inside predicate? 

   ```lisp
   (< (cond 
        (ϕ ψ)
		(δ γ)
		(t ζ))
	 τ)
   ```
   
   Use `if` axioms, in the "inverse mode" to simplify away. 
   
   ```lisp
   C1. (< ψ τ)
   C2. (implies ¬ϕ (< δ τ))
   C3. (implies ¬ϕ (implies ¬δ (< ζ τ)))
   ```
   
   Then we can use `if` as a way to show that if it holds in any of
   the cases, the logic makes it hold generally.

# Induction begins.

## Q: Where do induction schemes come from? 

## Last time: Induction more complicated in ACL2

  More complicated than you've seen before. More kinds of data. 
  More concerned with ensuring termination. 

## Every terminating function gives rise to an induction scheme

  EDIT: Do `ccc` induction example.
  
  ```lisp
  (definec nat-ind (n :nat) :nat
    (if (zp n)
	  0
	  (nat-ind (1- n))))
  ```

  ```
  1. (not (natp n)) ⇒ φ
  2. (natp n) ∧ (zp n) ⇒ φ
  3. (natp n) ∧ (not (zp n)) ∧ φ|((n n-1)) ⇒ φ
  ```

## Separate /induction/ cases from /base cases/. 
 
  1. Expand out all the macros 
  2. Find the terminals (doesn't have `if` s, not (subexpr of) the test), no casing. Unconditional code execution. 
  3. Maximal non-terminals are the biggest ones. the return calls.
  4. Every terminal has the conditions required to reach it. (how you get down to it)
  5. Set of recursive calls are the ones that have to be executed to execute the terminal. 
  6. Let `t₁ ... tₖ` be the maximal terminals with corresponding conditions
	 each with its corresponding sequence of recursive calls to `f` under a subst.
	 
	 `¬ic ⇒ φ`
	 For all basic terminals `tᵢ`: `ic ∧ cᵢ ⇒ φ`
	 For all recursive terminals `tᵢ`: `(ic ∧ cᵢ ∧ /\ 1≤j≤|rᵢ| φ|_ {σᵢʲ}) ⇒ φ`
	 
## Examples:

   ```lisp 
   (definec f (x :all) :all
     x)
	 
   (definec g (x :tl) :all
     x)
   ```	 

## Big example:



  ```lisp
  (definec app2 (x :tl y :tl) :tl
	(if (endp x)
		y
	  (cons (first x) (app2 (rest x) y))))

  (definec rev2 (x :tl) :tl
	(if (endp x)
		x
	  (app2 (rev2 (cdr x)) (list (car x)))))
n
  (implies (and (consp x)
				(implies (tlp (rest x))
						 (equal (rev2 (rev2 (rest x))) (rest x))))
		   (implies (tlp x)
					(equal (rev2 (rev2 x)) x)))

  ```

  ```lisp
  ;; Conjecture:
  (implies (and (consp x)
				(implies (tlp (rest x))
						 (equal (rev2 (rev2 (rest x))) (rest x)))
                (tlp x))
           (equal (rev2 (rev2 x)) x))

  ;; Context:
  C1. (consp x)
  C2. (implies (tlp (rest x)) (equal (rev2 (rev2 (rest x))) (rest x)))
  C3. (tlp x)
  
  ;; Derived Context:
  D1. (ne-tlp x) {C1, C3}
  D2. (tlp (rest x)) {D1}
  D3. (equal (rev2 (rev2 (rest x))) (rest x)) {MP, D2, C2}
  
  ;; Goal: 
  (equal (rev2 (rev2 x)) x)
  
  ;; Proof: 
  (rev2 (rev2 x))
  
  ;; (rev2 (app2 (rev2 (cdr x)) (list (car x))))
  ;; (app2 (cdr (rev2 x)) (list (car (rev2 x))))

  ;; The way to see this is that we don't have a straightforward recursive property here. 
  ;; The recursion is mediated through app2, another function. 
  ;; And we don't know anything about the relationship between rev2 and app2. 
  ;; What _is_ their relationship? 

  ;; Stuck? Induct!
  ```
  
  ```lisp
  (implies (and (tlp x)
	            (tlp y))
    (equal (rev2 (app2 x y)) (app2 (rev2 y) (rev2 x))))
	
  induct. base case
  
  ;; what _now_ 
  
  (implies (tlp x)
    (equal (app2 x nil) x))
  
  ;; 
  (implies (and (ne-tlp x) 
				(implies (and (tlp (rest x)) (tlp y))
				  (equal (rev2 (app2 (rest x) y)) (app2 (rev2 y) (rev2 (rest x))))))
	(implies (and (tlp x)
				  (tlp y))
	  (equal (rev2 (app2 x y)) (app2 (rev2 y) (rev2 x)))))
	  
	  
	(rev2 (app2 x y))
    (rev2 (cons (first x) (app2 (rest x) y)))
	(app2 (rev2 (app2 (rest x) y)) (list (first x)))
	(app2 (app2 (rev2 y) (rev2 (rest x))) (list (first x)))*** Lemma!
    (app2 (rev2 y) (app2 (rev2 (rest x)) (list (first x))))
	(app2 (rev2 y) (app2 (rev2 (rest x)) (list (first x))))
    (app2 (rev2 y) (rev2 x))

	QED 
	
	
	
  ```
  
  
  
  
  
	 
     
  
  
