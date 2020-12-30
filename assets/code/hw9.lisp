#| 

HW 9: The Proof of the Pudding

|#

#| 

Alrighty, I think we're ready for it. In class, we started
proving (permp x (rev2 x)) and I think we are ready to finish it
off. Below are our function definitions. Please bear in mind that, if
you are not careful, this file could become a mess, and you could find
yourself lost in a morass of your own failed attempts and forgotten
lemmata. Please use caution, and clean up after yourself. 

|#

(definec in (a :all L :lor) :bool
  (and (consp L)
       (or (== a (car l))
	       (in a (cdr L)))))

(definec del (a :all L :lor) :lor
  (cond 
    ((endp L) L)
    ((== a (car L)) (cdr L))
    (t (cons (car L) (del a (cdr L))))))
	
(definec permp (x :lor y :lor) :bool
  (if (endp x) (endp y)
	  (and (in (car x) y)
	       (permp (cdr x) 
		   (del (car x) y)))))

 (definec app2 (x :tl y :tl) :tl
	(if (endp x)
		y
	  (cons (first x) (app2 (rest x) y))))

  (definec rev2 (x :tl) :tl
	(if (endp x)
		x
	  (app2 (rev2 (cdr x)) (list (car x)))))

#| 
1. Problem 1 and only, the big kahuna. I want you all to prove, soup
to nuts, (permp x (rev2 x)). 

I think I'll start you off with some structure, though. 
|#

;; Conjecture.
(permp x (rev2 x))

;; We will proceed by induction on x. We must show:

;; P1.
    (implies (not (and (tlp x) (lorp x) (lorp (rev2 x)))) 
             (permp x (rev2 x)))

;; P2.
    (implies (and (tlp x) (lorp x) (lorp (rev2 x)))
             (implies (endp x) 
                      (permp x (rev2 x))))

;; P3.
    (implies (and (tlp x) (lorp x) (lorp (rev2 x)))
             (implies (not (endp x))
                      (implies (permp (cdr x) (rev2 (cdr x)))
                               (permp x (rev2 x)))))

;; Proof Obligation 1. 
(implies (not (and (tlp x) (lorp x) (lorp (rev2 x)))) 
             (permp x (rev2 x)))

;; Proof Obligation 2. 
(implies (and (tlp x) (lorp x) (lorp (rev2 x)))
             (implies (endp x) 
                      (permp x (rev2 x))))

;; Proof Obligation 3. 
(implies (and (tlp x) (lorp x) (lorp (rev2 x)))
             (implies (not (endp x))
                      (implies (permp (cdr x) (rev2 (cdr x)))
                               (permp x (rev2 x)))))

(implies (and (tlp x) (lorp x) (lorp (rev2 x)))
             (implies (not (endp x))
                      (implies (permp (cdr x) (rev2 (cdr x)))
                               (permp x (rev2 x)))))

(implies (and (tlp x)
	      (lorp x)
	      (lorp (rev2 x))
	      (not (endp x))
	      (permp (cdr x) (rev2 (cdr x))))
         (permp x (rev2 x)))

C1 (tlp x)
C2 (lorp x)
C3 (lorp (rev2 x))
C4 (not (endp x))
C5 (permp (cdr x) (rev2 (cdr x)))


Goal (permp x (rev2 x))

Proof
(permp x (rev2 x))
= permp def
(if (endp x) (endp (rev2 x))
	(and (in (car x) (rev2 x))
	     (permp (cdr x) 
		    (del (car x) (rev2 x)))))
= {IF def, endp}
(and (in (car x) (rev2 x))
     (permp (cdr x) 
	    (del (car x) (rev2 x))))
= {via Lemma (implies (in y x) (in y (rev2 x)))}
(and t
     (permp (cdr x) 
	    (del (car x) (rev2 x))))
= {and t if unfold}
(permp (cdr x) (del (car x) (rev2 x)))
= {del def}
(permp (cdr x)
       (cond 
	((endp (rev2 x)) (rev2 x))
	((== (car x) (car (rev2 x))) (cdr (rev2 x)))
	(t (cons (car (rev2 x)) (del (car x) (cdr (rev2 x)))))))
= {Lemma (implies (not (endp x)) (not (endp (rev2 x))))}
(permp (cdr x)
       (if (== (car x) (car (rev2 x)))
	   (cdr (rev2 x))
	 (cons (car (rev2 x)) (del (car x) (cdr (rev2 x))))))
= {If ax}
(if (== (car x) (car (rev2 x)))
    (permp (cdr x) (cdr (rev2 x)))
    (permp (cdr x) (cons (car (rev2 x)) (del (car x) (cdr (rev2 x))))))
= {Lemma 3, 4, 5 MP}
t 

;; Lemma 5
(implies (and (implies a b)
	      (implies (not a) c))
	 (if a b c))

Or use cases, via #70 in Ch2 

;; Lemma 4.1 
(implies (not (== (car x) (car (rev2 x))))
	 (equal (cons (car (rev2 x)) (del (car x) (cdr (rev2 x)))) (rev2 (cdr x))))
;; Lemma 4
(implies (not (== (car x) (car (rev2 x))))
	 (permp (cdr x) (cons (car (rev2 x)) (del (car x) (cdr (rev2 x))))))

;; Lemma 3.1
(implies (not (== (car x) (car (rev2 x)))) (equal (cdr (rev2 x)) (rev2 (cdr x))))

;; Lemma 3
(implies (== (car x) (car (rev2 x))) (permp (cdr x) (cdr (rev2 x))))

;; Lemma 2
(implies (not (endp x)) (not (endp (rev2 x))))
;; Lemma 1
(implies (in y x) (in y (rev2 x)))



;; Lemma 3.1
(implies (not (== (car x) (car (rev2 x))))
	 (equal (cdr (rev2 x)) (rev2 (cdr x))))

;; 
(implies (and (tlp x)
	      (consp x)
	      (consp (rev2 x))
	      (not (== (car x) (car (rev2 x)))))
	 (equal (cdr (rev2 x)) (rev2 (cdr x))))

;; Proof by Induction on X

(implies (and (tlp x)
	      (consp x)
	      (consp (rev2 x))
	      (not (== (car x) (car (rev2 x)))))
	 (equal (cdr (rev2 x)) (rev2 (cdr x))))





