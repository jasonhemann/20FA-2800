
(set-defunc-termination-strictp nil)
(set-defunc-function-contract-strictp nil)
(set-defunc-body-contracts-strictp nil)


(defdata lon (listof nat))

(definec countdown (n :nat) :lon
  (cond 
    ((zerop n) '(0))
    (t (cons n (countdown (- n 1))))))

(defdata sym-or-num (oneof nat symbol))

(defdata lons (listof sym-or-num))

(defdata first-last (list string string))

;; lon is oneof () or Cons Nat lon  




















