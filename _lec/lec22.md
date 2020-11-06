---
title: Generalization, but really, no. 
date: 2020-11-2
---

This isn't something I have much exciting to talk about.

Generalization is not enough of a topic for one day's
lecture. Honestly, a somewhat trivial section.

In any case we've already had to go far past this in work we've done.
Also we have already talked about it some. 

# Generalization, generally.


## To generalize, remove extraneous details

### Key principle

ϕ, then we also have ϕₛ, so don't concentrate on trying to prove ϕₛ.

Often times the extraneous details would make your lemma less useful
than they might otherwise be.

## Generalize the theorems. 

## Lemma Generation

"Let the lemmas come to you"

"Expand until you see the pattern emerge, then roll back up"

## But wait what *is* going on w/that induction? 

....

ϕ 

We proceed to prove by induction on x.

P1. "contract case" (implies (not (tlp ls)) ϕ)
P2. "function base case" (implies (and (tlp ls) (base ls)) ϕ)
P3. "recursive case" 
(implies (and (tlp ls) 
              (not (basep ls))
              ϕ_(ls (rest ls)))
          ϕ)

P1 ^ P2 ^ P3 -> ϕ.

### So what do I put in my proof? like wording? 

This will do.

"Having proved P1 P2 P3, we now have ϕ".

## Induction Failure

Let the form of the induction follow the data. 

Use a different induction system. 

## The problem where we left off

How about we work farther on the problem where we left off?

We were proving `(permp x (rev x))`. We could continue from here.


## With accumulators 

### Scylla and Charybdis

We have one definition that is simple, but inefficient. We also have
another function definition that is more complex, but efficient.

```lisp
(definec plus (n :nat m :nat) :nat
  (cond
    ((zp m) n)
	(t (1+ (plus n (1- m))))))
```

```lisp
(definec plus (n :nat m :nat) :nat
  (cond
    ((zp m) n)
	(t (plus (1+ n) (1- m)))))
```

```lisp
 (definec app2 (x :tl y :tl) :tl
	(if (endp x)
		y
	  (cons (first x) (app2 (rest x) y))))

  (definec rev2 (x :tl) :tl
	(if (endp x)
		x
	  (app2 (rev2 (cdr x)) (list (car x)))

  
  (definec rev/acc (x :tl acc :tl) :tl
	(if (endp x) 
	    acc
	    (rev/acc (cdr x) (cons (car x) acc))))



  (definec rev (x :tl) :tl 
    (rev/acc x '()))
```




```lisp
(definec reverse (ls)
  (cond
	[(null? ls) '()] // endp
	[t
	 (if (null? (cdr ls))
	 ls
	 (let ((rd (reverse (cdr ls))))
	   (cons (car rd) (reverse (cons (car ls) (reverse (cdr rd)))))))]))
```
