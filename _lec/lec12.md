---
title: Projects layout plus pen-and-paper proofs
date: 2020-10-07
---



# Admin Stuff 

## HW, Projects, Meetings

Time to talk in class on this

### Examples 

 1. Cryptarithmetic `Send + More = Money` etc

	``` 
	  CAN
	+ GET
	----------
	 CASH

	  CAN
	+ HAS
	----------
	 CASH
	```

 2. Sudoku, and discuss how it's done 
 3. Crossword w/a dictionary: feasible? 
 4. map coloring problem, map coloring + oblasts? 
 5. word search w/<=k words? 
 6. Marble/peg solitaire 15 golf ball tees puzzle
 7. (n-queens)
 8. Rubix cube (show example solns) Do we know what the most complicated configurations are for a rubix cube??


### Meeting time. 

### HW 5, 8 should be lighter. 
 (Lighter HW *B/C* of project) 

#### 3. Write the sentence "I am taking this extra time to work on our project!"

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

