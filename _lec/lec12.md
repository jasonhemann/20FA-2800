---
title: 
date: 2020-10-07
---



# Admin Stuff 

## HW, Projects, Meetings

### The pen-and-paper prover isn't fully battle-ready.


# Class Examples of Pen-and-Paper Proofs.
  ```lisp
  (definec len2 (x :tl) :nat
	(if (endp x)
		0
	  (+ 1 (len2 (rest x)))))

  (definec in2 (a :all l :tl) :bool
	(if (endp l)
		nil
	  (or (== a (first l)) (in2 a (rest l)))))

  (definec app2 (x :tl y :tl) :tl
	(if (endp x)
		y
	  (cons (first x) (app2 (rest x) y))))

  (definec rev2 (x :tl) :tl
	(if (endp x)
		x
	  (app2 (rev2 (cdr x)) (list (car x)))))
  ```
  
### Is this true?


   ```lisp
   (implies (endp ls)
     (implies (tlp ls)
	   (implies (in2 a ls)
	            (in2 a (rev2 ls))))
	 ```


   ```lisp
   (implies (consp ls)
	 (implies 
	   (implies (tlp (rest ls))
		 (implies (in2 a (rest ls))
				  (in2 a (rev2 (rest ls)))))
	   (implies (tlp ls)
		 (implies (in2 a ls)
				  (in2 a (rev2 ls)))))
	 ```


### Fix it and prove.

### Come back together and work together

## Code Review 

## An answer from lab or HW

