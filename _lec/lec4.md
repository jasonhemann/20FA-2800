---
title: (Remainder) of the Dirty Dozen
date: 2020-09-16
---

# Reading 

_Pre_reading. Make sure and do it. Some expectation for situated questions.

# Labs and Piazzas

Make sure you're in our session. Some of us in the other room and it's 

# `thm`

  E.g. 

  ```lisp
  (thm (implies 
		 (implies a 
				  (implies b c))
		 (implies (implies a b) 
				  (implies a c))))
  ```

  Like, you too could reason through that, but it's not trivial. 


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
