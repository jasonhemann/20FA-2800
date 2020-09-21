#|

 Propositional Logic Lecture

 |#

(set-defunc-function-contract-strictp nil)
(set-defunc-body-contracts-strictp nil)

(defdata foo (oneof boolean `(s ,foo)))


(foop (list 's (list 's (list 's t))))

(defdata bar (oneof boolean `(s bar)))


;; Why it's important to separate syntax from semantics 

(defdata blogexpr 
  (oneof 
   'tt
   'ff
   `(! ,blogexpr)  ;; not 
   `(,blogexpr & ,blogexpr)  ;; and 
   `(,blogexpr v ,blogexpr)  ;; or 
   `(,blogexpr => ,blogexpr) ;; implies, "if .. then .."  
   `(,blogexpr == ,blogexpr) ;; iff "if and only if" 
   `(,blogexpr >< ,blogexpr) ;; xor eXclusive or
         ))


;; A => B 
;; (! A) v B

(definec valof (be :blogexpr) :bool
  (case-match be
    (('! be1) (not (valof be1)))
    ((be1 '& be2) (if (valof be1) (valof be2) nil))
    ((be1 'v be2) (if (valof be1) t (valof be2)))
    ((be1 '=> be2) (if (valof be1) (valof be2) t))
                   ;; if we have b1, then we must have b2
                   ;; if we don't have b1, then the => is true no matter what
    ((be1 '== be2) (if (valof be1) (valof be2) (not (valof be2))))
    ((be1 '>< be2) (if (valof be1) (not (valof be2)) (valof be2)))
    ('tt t)
    ('ff nil)))

;; Validity
;; Satisfiability
;; Falsifiability

(thm (implies (implies phi (implies psi xi))
              (implies
               (implies phi psi)
               (implies phi xi))))

