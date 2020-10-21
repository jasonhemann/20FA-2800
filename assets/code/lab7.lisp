;; A short one. Just more practice; you all other important tasks to
;; be working on atm.

#|

Lab 7. More on Measures

For the definition below, come up with an acceptable measure function,
and use that to show that your function will terminate. 

NB! A function being admissible by the definitional principle is not
the same as ACL2s automatically proving that it is admissible.  

1. There are many functions that are admissible, but ACL2s will not
   admit them without help from the user. 

2. It is possible that ACL2s has bugs! If so, it is possible that it
   erroneously proves admissibility in some cases.

The point is that you cannot justify admissibility by saying "I typed
it into ACL2s and it was admitted. QED". 

|# 

#| 

 Here is a function that you may find useful when constructing a
 measure function for the magnitude function given below.
 The ceil function is non-recursive, so you don't have to prove
 its termination.

|# 

(definec ceil (x :non-neg-rational) :nat
  (ceiling x 1))

; Here are some tests showing that (how) ceil works.

(check= (ceil 11) 11)
(check= (ceil 10/3) 4)
(check= (ceil 10/101) 1)

;; Oh no! ACL2s is in trouble! It needs *YOUR* help!  
:program

(definec magnitude (x :non-neg-rational) :integer
  (cond 
    ((equal x 0) 0)
    ((>= x 10) (+ 1 (magnitude (/ x 10))))
    ((< x 1) (* -1 (magnitude (/ 1 x))))
    (t 1)))

;; 1. Come up with a measure.

#| 

To do so, you will have to understand how magnitude works. One way to
do that is to "trace" it and try running it on examples.

|# 

(trace$ magnitude)

(magnitude 20)
(magnitude 200000)
(magnitude 200000000000)
(magnitude 1/20)
(magnitude 1/200000)
(magnitude 1/200000000000)


;; 2. Demonstrate that your measure function is in fact a measure
;; function, by proving it is a correct measure (via pen-and-paper,
;; written equational proof) for the recursive calls.




