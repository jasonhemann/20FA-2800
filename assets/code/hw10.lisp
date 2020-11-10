#| 

HW 9: The Proof of the Pudding

|#

#| 

Okay, another single-problem HW assignment. I think this'll be a good
one. Let's do it!

Theorem-heads out there, FYE, please find on the course website my
proof of the <= fib fact claim in Idris, a theorem prover of a very
different sort.

{{ site.baseurl}}/assets/code/factfib.idr

|#

;; In the context of these functions

(definec fact (n :nat) :nat
  (if 0 1
    (* n (fact (1- n)))))

(definec fib (n :nat) :nat
  (if (< n 2)
    n
    (+ (fib (1- n)) (fib (1- (1- n))))))

(definec fib2 (n :nat) :nat
  (if (zp n)
    0
    (fib-acc2 (1- n) 0 1)))

(definec fib-acc2 (c :nat ans-1 :nat ans :nat) :nat
  (if (zp c)
      ans
      (fib-acc2 (1- c) ans (+ ans-1 ans))))

;; Your task is to prove:

(<= (fib2 n) (fact n))

;; Go wild! 

(<= (fib2 n) (fact n))
= {Lemma fib-fib2}
(<= (fib n) (fact n))

;; Induction on x via fib

(implies (not (natp n)) (<= (fib n) (fact n)))

(implies (and (natp n) (< n 2)) (<= (fib n) (fact n)))

(implies (and (natp n)
	      (not (< n 2))
	      (<= (fib (- n 2)) (fact (- n 2)))
	      (<= (fib (- n 1)) (fact (- n 1))))
	 (<= (fib n) (fact n)))



(implies (and (natp n)
	      (not (< n 2))
	      (<= (fib (- n 2)) (fact (- n 2)))
	      (<= (fib (- n 1)) (fact (- n 1))))
	 (<= (fib n) (fact n)))


;; Context
C1 (natp n)
C2 (not (< n 2))
C3 (<= (fib (- n 2)) (fact (- n 2)))
C4 (<= (fib (- n 1)) (fact (- n 1)))

;; DC 


;; Goal
(<= (fib n) (fact n))

;; Proof
(<= (fib n) (fact n))
= {def fib, fact}
(<=  (if (< n 2)
	 n
       (+ (fib (1- n)) (fib (1- (1- n)))))
     (if 0 1
       (* n (fact (1- n)))))
= { }
(<=  (+ (fib (1- n)) (fib (1- (1- n)))) (* n (fact (1- n))))
= { }

(<= (+ (fib (- n 2)) (fib (- n 1)))
    (+ (fact (- n 2)) (fact (- n 1))))
;; Lemma
(<= (+ (fact (- n 2)) (fact (- n 1))) (* n (fact (1- n))))

(<= (+ (fact (- n 2)) (fact (- n 1))) (* n (fact (1- n))))

;; Lemma
(<= (+ (fact (1- n)) (fact (1- n))) (* n (fact (1- n))))
