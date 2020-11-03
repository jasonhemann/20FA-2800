#| 

Lab 9 

|# 

;; First and only problem. This is a thinker. 

;; 1. Consider the following definitions of plus and plus2
;; These may seem familiar.

(definec plus (n :nat m :nat) :nat
  (cond
    ((zp m) n)
    (t (1+ (plus n (1- m))))))

(definec plus2 (n :nat m :nat) :nat
  (cond
    ((zp m) n)
    (t (plus2 (1+ n) (1- m)))))

;; Here is the Conjecture:
(equal (plus n m) (plus2 n m))

;; Please attempt to prove this conjecture. I will not *require* you
;; to prove it.

;; But please at least try to do so and get really, well, and truly
;; *stuck*. If you do manage to prove it, that would be fine also, but
;; I'm not expecting that.

;; I believe that you will find the inductive case to be the
;; challenge; so you might as well table the contract case and the
;; base case, and come back to those if you're on the cusp of
;; completing it.


