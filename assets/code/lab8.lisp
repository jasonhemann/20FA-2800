#| 

Lab 8: Induction

|#

;; Ye olde pre-existing defnns
 (definec app2 (x :tl y :tl) :tl
	(if (endp x)
		y
	  (cons (first x) (app2 (rest x) y))))

  (definec rev2 (x :tl) :tl
	(if (endp x)
		x
	  (app2 (rev2 (cdr x)) (list (car x)))))

#| 

PART I - BEGINNING A BIG OL' INDUCTIVE PROOF

I want you to have the experience of working *through* the proof in
the order in which we'd come to it.

But I want to give you some structure as you work through a
non-trivial inductive proof.

And I want to avoid you having to re-write a whole lot of this. 

So, I'm going to give you a starting bit. I have restated the parts of
the proof we started in class. I have also indicated when we "get
stuck" and need to resort to a lemma.

You will complete some key lemmata in this lab.

In your homework, we will then use those complete lemmata to complete
the remainder of the larger proof.

|# 


#|

;; NB. This is the main proof we begin here and complete in the
;; homework.

;; Conjecture:
(implies (and (consp x)
	      (implies (tlp (rest x))
		       (equal (rev2 (rev2 (rest x))) (rest x))))
	 (implies (tlp x)
		  (equal (rev2 (rev2 x)) x)))

;; Exportation:
(implies (and (consp x)
	      (implies (tlp (rest x))
		       (equal (rev2 (rev2 (rest x))) (rest x)))
	      (tlp x))
	 (equal (rev2 (rev2 x)) x))

;; Contract Completion:
(implies (and (consp x)
	      (implies (tlp (rest x))
		       (equal (rev2 (rev2 (rest x))) (rest x)))
	      (tlp x)
	      (tlp (rev2 x))
	      (tlp (rev2 (rest x))))
	 (equal (rev2 (rev2 x)) x))

;; Context
C1. (consp x)
C2. (implies (tlp (rest x)) (equal (rev2 (rev2 (rest x))) (rest x)))
C3. (tlp x)
C4. (tlp (rev2 x))
C5. (tlp (rev2 (rest x)))

;; Derived Context:
D1. (tlp (rest x)) {C1, C3}
D2. (equal (rev2 (rev2 (rest x))) (rest x)) {C2, D1, MP}
D3. (tlp (rev2 (rev2 (rest x)))) {D1, D2}

;; Goal:
(equal (rev2 (rev2 x)) x)

;; Proof:
(rev2 (rev2 x))
= {Def. rev2}
(rev2 (app2 (rev2 (cdr x)) (list (car x))))

... ¯\_(ツ)_/¯

|# 

#| 
Intermezzo: 

Right now, we're stuck here. We cannot proceed because there's an app2
call in the way and we don't know about the relationship between app2
and rev2. 

That app2 call is in the way of our making good use of the inductive
hypothesis.  

We need a lemma!  

Hrmm.... How do app2 and rev2 relate to one another? An example:

(rev (app '(1 2 3) '(4 5 6))) = (app (rev '(4 5 6)) (rev '(1 2 3)))
'(6 5 4 3 2 1)                    

Ergo, (equal (rev2 (app2 x y)) (app2 (rev2 y) (rev2 x)))

NB. We'd also be stuck here with the other approach, but stuck even
worse:

(app2 (rev2 (cdr (rev2 x))) (list (car (rev2 x)))).  

Either way this calls for a lemma!!!

|#

#| 
Lemma 1: rev-app
(equal (rev2 (app2 x y)) (app2 (rev2 y) (rev2 x)))

This will require a proof by induction on x. 

We will need to show three different facts:

(implies
  (not (tlp x))
  (equal (rev2 (app2 x y)) (app2 (rev2 y) (rev2 x))))

;; NB. Begun here, completed on homework.
(implies (tlp x)
  (implies (endp x)
	  (equal (rev2 (app2 x y)) (app2 (rev2 y) (rev2 x)))))

;; NB. On homework
(implies (tlp x)
 (implies (not (endp x))
   (implies (equal (rev2 (app2 (rest x) y)) (app2 (rev2 y) (rev2 (rest x))))
            (equal (rev2 (app2 x y)) (app2 (rev2 y) (rev2 x))))))

|#

#| 
;; 1. Lemma 1a: rev-app-not
;; Conjecture:
(implies
  (not (tlp x))
  (equal (rev2 (app2 x y)) (app2 (rev2 y) (rev2 x))))

;; Contract completion:
...

|#

#| Lemma 1b: rev-app-base
;; Conjecture
(implies (tlp x)
  (implies (endp x)
	  (equal (rev2 (app2 x y)) (app2 (rev2 y) (rev2 x)))))

;; Exportation
(implies
 (and (tlp x)
      (endp x))
 (equal (rev2 (app2 x y)) (app2 (rev2 y) (rev2 x))))

;; Contract completion:
(implies
 (and (tlp x)
      (tlp y)
      (endp x)
      (tlp (app2 x y))
      (tlp (rev2 y))
      (tlp (rev2 x)))
 (equal (rev2 (app2 x y)) (app2 (rev2 y) (rev2 x))))

;; Context
C1. (tlp x)
C2. (tlp y)
C3. (endp x)
C4. (tlp (app2 x y))
C5. (tlp (rev2 y))
C6. (tlp (rev2 x))

;; Derived context
D1. (equal x nil)
D2. (tlp (app2 nil y))

;; Goal
(equal (rev2 (app2 x y)) (app2 (rev2 y) (rev2 x)))

;; Proof
(rev2 (app2 x y))
= {D1}
(rev2 (app2 nil y))
= {Def. app2}
(rev2 (if (endp nil)
          y
	  (cons (first nil) (app2 (rest nil) y))))
= {Ax. endp}
(rev2 (if t
          y
	  (cons (first nil) (app2 (rest nil) y))))
= {if-axioms}
(rev2 y)

... ¯\_(ツ)_/¯

|#

#| 

But here we get stuck! Whatever shall we do! 
We don't know enough to reduce the other side of the
inequality. Whatever shall we do? ... INDUCTION!

|# 

#| 
Lemma 2: app-nil
(equal (app2 x nil) x)

This will require a proof by induction on x. We will need to show
three different facts:

(implies (not (tlp x))
         (equal (app2 x nil) x))

(implies (tlp x)
         (implies (endp x)
                  (equal (app2 x nil) x)))

(implies (tlp x)
         (implies (not (endp x))
                  (implies (equal (app2 (cdr x) nil) (cdr x))
                           (equal (app2 x nil) x))))
|#

#| 
;; Lemma 2a app-nil-not
;; Conjecture
(implies (not (tlp x))
         (equal (app2 x nil) x))

;; Contract completion
... 

|#

#| 
;; Lemma 2b app-nil-nil
;; Conjecture
(implies (tlp x)
         (implies (endp x)
                  (equal (app2 x nil) x)))

;; Exportation
... 

|#

#| 
;; Lemma 2c app-nil-cons
;; Conjecture
(implies (tlp x)
         (implies (not (endp x))
                  (implies (equal (app2 (cdr x) nil) (cdr x))
                           (equal (app2 x nil) x))))

;; Exportation
... 

|#

;; We will continue from here in the homework.

#| 
;; PART II A READING ASSIGNMENT ABOUT BIG NUMBERS
				       
This is a reading assignment. You will have to read, and be perpared
to discuss, the following article:     
				       
https://www.scottaaronson.com/writings/bignumbers.html
				       
There will (likely) be an in-class discussion based on this. So you
should absolutely expect to have this understanding checked and
verified. 			       
				       
You should also be prepared to answer some questions individually
about this article.		       
				       
|# 

