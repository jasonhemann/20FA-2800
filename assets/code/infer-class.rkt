#lang racket
(require minikanren)
(require rackunit)



;; (fix (x) b) : (tau -> tau)

;; ((lambda (x) (x x))
;;  (lambda (!)
;;    (lambda (n)
;;      (if (zero? n)
;;          1
;;          (* n (! (sub1 n)))))))

;; ( -> (Nat -> Nat))

#| 

 Γ !- ne1 : Nat  Γ !- ne2 : Nat
--------------------------------
 Γ !- (+ ne1 ne2) : Nat 


Γ !- t : Bool  Γ !- c : τ  Γ !- a : τ 
--------------------------------------
    Γ !- (if t c a) : τ 

(add1 true)

1. Progress
2. Preservation

|# 

;; 1. Functions (lambdas and applications)
;; 2. How do we check types?
;; 3. Whiz-bang!

#| 

  Γ !- e1 : τ₁ -> τ     Γ !- e2 : τ₁       
---------------------------------------
   Γ !- (e1 e2) : τ  

    x : σ, Γ !- b : τ 
-------------------------------------------
   Γ !- (lambda (x) b) : σ -> τ 

    Γ(x) = τ  
---------------------------- x is a symbol
   Γ !- x : τ 
|# 

;; String FindName (int emplIdNum);
;; (lambda (f) (lambda (x) (f x)))

(define (lookupo env y τ)
  (fresh (x v d)
    (== `((,x . ,v) . ,d) env)
    (conde
      ((== x y) (== v τ))
      ((=/= x y) (lookupo d y τ)))))

(define (!- Γ e τ)
  (conde
    ((symbolo e)
     (lookupo Γ e τ))
    ((numbero e)
     (== τ 'Nat))
    ((== τ 'Bool)
     (conde
       [(== e #t)]
       [(== e #f)]))
    ((fresh (ne1 ne2)
       (== e `(+ ,ne1 ,ne2))
       (== τ 'Nat)
       (!- Γ ne1 'Nat)
       (!- Γ ne2 'Nat)))
    ((fresh (ne)
       (== e `(sub1 ,ne))
       (== τ 'Nat)
       (!- Γ ne 'Nat)))
    ((fresh (ne)
       (== e `(zero? ,ne))
       (== τ 'Bool)
       (!- Γ ne 'Nat)))
    ((fresh (t c a)
       (== e `(if ,t ,c ,a))
       (!- Γ t 'Bool)
       (!- Γ a τ)
       (!- Γ c τ)))
    ((fresh (f)
       (== e `(fix ,f))
       (!- Γ f `(,τ -> ,τ))))
    ;; ((fresh (w f)
    ;;    (== e `(fix (lambda (,w) ,f)))
    ;;    (!- `((,w . ,τ) . ,Γ) f τ)))
    ((fresh (x b)
       (== e `(lambda (,x) ,b))
       (fresh (τ₁ τ₂)
         (== τ `(,τ₁ -> ,τ₂))
         (!- `((,x . ,τ₁) . ,Γ) b τ₂))))
    ((fresh (e1 e2)
       (== e `(,e1 ,e2))
       (fresh (τ₁)
         (!- Γ e1 `(,τ₁ -> ,τ))
         (!- Γ e2 τ₁))))))


#| The fixpoint of a function f is, incidentally what we used on page
27 of Ch 2 of Pete's textbook to build, say, the lists.

|# 
(define (fix f)
  (letrec ([g (λ (x) ((f g) x))])
    g))


#| 

–––––––––––––––––––––
(x x) ((((((( -> ) -> ) -> ) -> ) -> ) -> ) -> ) -> 
|#

