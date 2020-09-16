
;; Here's what I had for this week's lab. Enough content?

;; I thought start with qs from students. 

;; Define a function MY-MEMBER that behaves like Lisp's MEMBER
;; function

;; Define a function RAC that returns the last element of a non-empty
;; list. (RAC, because it's like CAR, but the other way.)

;; (definec rac (xs :ne-tl) :all
;;   ...
;;   )

(check= (rac '(a)) 'a)
(check= (rac '(a b c)) 'c)

;; Define SNOC, and RDC, which do the now obvious-by-analogy things.

;; Define NAT-TO-BINARY, that takes a nat and returns a little-endian
;; binary number

(check= (nat-to-binary 0) '())
(check= (nat-to-binary 1) '(1))
(check= (nat-to-binary 6) '(0 1 1))

;; Define REMOVE, a function that takes an element of the universe x
;; and a true-list l, and removes each occurrence of x from l. Does
;; not recur deeply.


#| 

A predicate is a name for functions with codomain {t, nil}. We use the
word predicate, because we can think of such a function as defining a
way to separate the function's domain into the elements that have the
property, and those elements that do not have the property. 

|# 

#| 

As you will remember from discrete, a set is a collection of elements
without order or multiplicity. We will represent our sets with
lists. As we know, the order of elements matters. This implies that
for functions like LIST-SET-DIFFERENCE, we will need a test more
generous than mere list equality to determine whether an
implementation is correct. Consider and bear this in mind.

|# 


;; Define LIST-SET, a predicate on true-lists that returns t when the
;; list is free of duplicates, and nil otherwise.

(check (list-set '(a b c d f (a b c))))
(check (list-set '()))
(check (list-set '(a (a) ((a)))))
(check (not (list-set '(a x b x c d))))
(check (not (list-set '(a (x) b (x) d))))


;; Define LIST-SET-DIFFERENCE, a function that takes two list-sets s1
;; and s2 and returns a list-set containing all the elements of s1
;; that are not elements of s2.

;; Define PALINDROME-ME, a function on true lists that turns each list
;; into a palindromed version of itself.

(definec palindrome-me-acc (l :tl acc :tl) :tl
  (cond
    ((not l) acc)
    (t (cons (car l) (palindrome-me-acc (cdr l) (cons (car l) acc))))))
  

(definec palindrome-me (l :tl) :tl
  (palindrome-me-acc l '()))
  
(palindrome-me '(a b c d e))

;; Then walk them through the complexity kinds of questions. Same kind
;; of stuff on the HW: I swiped the qs from Pete. Ask if you want/need
;; details, I'll find some time to give the lecture to you all to give
;; to them. Students just /ate/ my time /up/ with questions this
;; week. I'm glad they're so enthused. 

