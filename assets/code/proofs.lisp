(defdata lor (listof rational))

(definec len2 (x :tl) :nat
  (if (endp x)
      0
    (+ 1 (len2 (rest x)))))

(definec in2 (a :all l :tl) :bool
  (if (endp l)
      nil
    (or (== a (first l)) (in2 a (rest l)))))
    
(definec app2 (x :tl y :tl) :tl
  (if (endp x)
      y
    (cons (first x) (app2 (rest x) y))))

(definec rev2 (x :tl) :tl
  (if (endp x)
      x
    (app2 (rev2 (cdr x)) (list (car x)))))

(definec in3 (a :rational L :lor) :bool
  (and (consp L)(or (equal a (car l))(in a (cdr L)))))

       (definec del2 (a :all l :tl) :tl
         (cond 
           ((endp l) l)
           ((equal a (car l)) (cdr l))
           (t (cons (car l) (del2 a (cdr l))))))

       
    
(defthm in-list-implies-in-rev-list
   (implies (ne-tlp ls)
     (implies 
       (implies (tlp (rest ls))
         (implies (in2 a (rest ls))
                  (in2 a (rev2 (rest ls)))))
       (implies (tlp ls)
         (implies (in2 a ls)
                  (in2 a (rev2 ls)))))))


;; We stopped here. 









(defthm app2-associative
  (implies (and (tlp x) (tlp y) (tlp z))
           (equal (app2 (app2 x y) z)
                  (app2 x (app2 y z)))))

(defthm app-rev 
  (implies (and (tlp x) (tlp y))
           (equal (rev2 (app2 x y)) 
                  (app2 (rev2 y) (rev2 x)))))

(defthm in-rev-ind 
     (implies (consp ls)
     (implies 
       (implies (tlp (rest ls))
         (implies (in2 a (rest ls))
                  (in2 a (rev2 (rest ls)))))
       (implies (tlp ls)
         (implies (in2 a ls)
                  (in2 a (rev2 ls)))))))


(defthm in-rev
       (implies (tlp ls)
         (implies (in2 a ls)
                  (in2 a (rev2 ls)))))

