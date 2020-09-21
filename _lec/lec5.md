---
title: Propositional Logic
date: 2020-10-21
---

# Reading 

Pre-reading quiz. 

# Brief History of Logic

  Greeks. Wanted ways to know when something _had_ to be
  true. Sophists and smooth talkers. Persuasive. When it had to be
  true as a consequence of the things we already take to be
  true. Forms of argumentation.

  Heraclitus "Everything is in motion", "you cannot step into the same
  stream twice."

  Parmenides "Everything is constant, unchanging, eternal"

  Plato gives us, in the allegory of the cave, the fusion of these two ideas. 

  The things we see are echos, shadows of the platonic ideal.

  300-400 BC: A fascinating time. 

# Euclid's geometry. 

  From basic principles, we can deduce more complicated facts. 
  These are the things that follow from others, analytically.
  
  whereas synthetics are the things we induce from experience. 

# Aristotle's logic. Part-whole logic. 

  
  Lots more, fascinating story. How we get from Aristotle, through the
  scholastics, through the renaissance and 16th and 17th century
  mathematics. 

# Boolean logic, algebratization. Propositional. 

  Stop off with Boolean logic. George Boole. American.

  The logic of propositions. Sentences. 

##  Determine the values of complicated expressions based on the values of smaller expressions. 
  
##  We can determine the meaning of the whole with the values of the immediately smaller sub-pieces. 
  
## Implication.
 
   Difficult and frustrating at times, for students. B/c the way we
   use implication here isn't the way you would normally use it.

  "Show me a man with a tattoo, and I’ll show you a man with an interesting past." —Jack London
  
    
  Truth tables. 



	  ```
	NOT     !

	AND     &
	OR      v

	IMPLIES =>

	EQUIV   ==
	XOR     ><
	  ```


  
  - Validity
  
  - Falsifaibility
  
  - Satisfiability
  
  - Unsatisfiable
  
  








# `not` v. `endp` v. `lendp` 

`cond` cases

# `quasiquote` and `unquote`

## Just the facts ma'am.

## 3D code examples.

# `t`, `nil` are symbols!? Yeah. 

## Not so weird, you know languages where 0 and 1 are the boolean values, so ....

# More macros

## Macros: a way to write down shorthand that expands into a long-form.

## We will use them; we shall not construct our own. 

## I went and checked: `first` is just `car`, etc

## `caddar` `cdddr`

## `definec` vs. `defunc`: when it gets complicated

	``` lisp
	(defunc lsd (s1 s2)
	  :ic (and (tlp s1) (tlp s2) (list-set s1) (list-set s2))
	  :oc (and (tlp (lsd s1 s2)) (list-set (lsd s1 s2)))
	  (cond
		((lendp s2) s1)
		(t (remove (car s2) (lsd s1 (cdr s2)) :test 'equal))))
    ```

# Program mode, logic mode, tracing.

## Tracing programs with

`trace$`

`untrace$`

## Try tracing executions of the following:

```lisp
(definec tapp (x :tl y :tl) :tl
  (declare (xargs :mode :program))
  (cond 
   ((lendp x) y)
   (t (lcons (head x) (tapp (tail x) y)))))
```
vs. 

```lisp
(definec tapp (x :tl y :tl) :tl
  (cond 
   ((lendp x) y)
   (t (lcons (head x) (tapp (tail x) y)))))
```

static contract checking! What a win!
