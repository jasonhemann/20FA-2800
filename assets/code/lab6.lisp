#|

Lab 6. Admissibility.

We now deliberately removed our earlier allowances that let us elide
checking function and body contracts. But we now know what to do about
these! 

For each definition below, check whether it is admissible, i.e., it
satisfies all conditions of the Definitional Principle. You can assume
that Condition 1 is met: the symbol used is a new function symbol.

A. If you claim that the function is admissible:

a) provide a measure function that can be used to prove termination

b) state the contract theorem (condition 5)

c) prove that the function is terminating using your measure function
   and equational reasoning

B. If you claim the function is not admissible, identify a condition 
   that is violated, subject to:

  - If conditions 2 or 3 are violated (formals are not distinct or
    body is not a term), explain the violation in English. 

  - If one of the other conditions is violated, provide an input that
    satisfies the input contract but causes the condition to
    fail. 
 
  - Even if multiple conditions are violated, you only have to find
    one such condition. 

|#

(definec f1 (x :nat) :int 
  (if (zp x)
      3
    (- 23 (f1 (+ f1 x)))))

...


(definec f2 (x :nat) :int 
  (if (zp x)
      3
    (- 23 (f2 x (f2 x)))))

...

(definec f3 (x :nat) :int 
  (if (zp x)
      3
    (+ 99 (f3 (1- x)))))

...

(definec f4 (x :nat) :int
  (if (zp x)
      3
    (* 2 (f4 (- x 2)))))

...

(definec f5 (x :int) :int
  (if (< x 0)
      3
    (* 2 (f5 (- x 2)))))

...

(definec f6 (x :nat y :nat) :nat
  (cond ((zp x)   y)
        ((<= y x) x)
        ((<= y 1) (f6 (1+ x) (1+ y)))
        (t        (f6 (1- x) (1+ y)))))

...

(definec f7 (x :tl y :nat) :tl
  (cond ((zp y)   nil)
        ((endp x) (list y))
        ((= y 1)  (f7 (rest x) y))
        (t        (f7 (cons y x) (- y 1)))))

...

(definec f8 (x :tl y :int) :tl
  (if (< y 0)
      x
    (f8 (rest x) (- y 1))))

...
