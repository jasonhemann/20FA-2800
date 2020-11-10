#| 

Lab 10: Everything We've Accumulated

|#

;; In class, we developed these two programs: 

(definec powof3 (b :nat) :nat
  (if (zp b) 
      1
    (* 3 (powof3 (1- b)))))

(definec powof32h (b :nat c :nat) :nat
  (if (zp b)
      c
    (powof32h (1- b) (* 3 c))))

(definec powof32 (b :nat) :nat
  (powof32h b 1))

;; Further, we asserted that this was the theorem we wished to show.
(implies (natp n) (equal (powof3 n) (powof32 n)))

;; We were to proceed by induction on n using the powof3 induction
;; scheme

;; 1. Contract Case
(implies (not (natp n))
	 (implies (natp n) (equal (powof3 n) (powof32 n))))

;; (You do...!)

;; 2. Base Case
(implies (and (natp n) (zp n))
	 (implies (natp n) (equal (powof3 n) (powof32 n))))

;; (You do...!)

;; Recursive Case
(implies (and (natp n)
	      (not (zp n))
	      (implies (natp (- n 1)) (equal (powof3 (- n 1)) (powof32 (- n 1)))))
	 (implies (natp n)
		  (equal (powof3 n) (powof32 n))))

;; Exportation
(implies (and (natp n)
	      (not (zp n))
	      (implies (natp (- n 1)) (equal (powof3 (- n 1)) (powof32 (- n 1))))
	      (natp n))
	 (equal (powof3 n) (powof32 n)))

;; Context
C1 (natp n)
C2 (not (zp n))
C3 (implies (natp (- n 1)) (equal (powof3 (- n 1)) (powof32 (- n 1))))
C4 (natp n)

;; DC
D1 (equal (powof3 (- n 1)) (powof32 (- n 1))) {C1 C2 arith C3}
D2 (equal (powof32h n 1) (* 1 (powof3 n))) {C1, Def natp, MP, Lemma pow3-pow32h-acc} ****

;; Goal 
(equal (powof3 n) (powof32 n))

;; Proof
(powof32 n)
= {defn powof32}
(powof32h n 1)
= {D2}
(* 1 (powof3 n))
= {Arith}
(powof3 n)

QED

;; This proof critically relied on that Lemma pow3-pow32h-acc
;; 2. A lemma, relating the acc'd workhorse fn w/ the direct one.

(implies (and (natp c)
	      (natp n))
	 (equal (powof32h n c) (* c (powof3 n))))

;; This was the flavor of thing we'd need to prove by induction. We'll
;; prove it by induction on n, with the induction schema of powof32h.

;; 5. Contract Case
(implies (not (and (natp c) (natp n)))
	 (implies (and (natp c)
		       (natp n))
		  (equal (powof32h n c) (* c (powof3 n)))))

;; 6. Base Case
(implies (and (natp c) (natp n))
	 (implies (zp n)
		  (implies (and (natp c)
				(natp n))
			   (equal (powof32h n c) (* c (powof3 n))))))

;; 7. Induction Case
(implies (and (natp c) (natp n))
	 (implies (not (zp n))
	          (implies (implies (and (natp c)
		                         (natp (- n 1)))
			            (equal (powof32h (- n 1) c) (* c (powof3 (- n 1)))))
			   (implies (and (natp c)
					 (natp n))
				    (equal (powof32h n c) (* c (powof3 n)))))))


;; Part II: The Set-up

#| 

Since we will be returning to Racketry, at least in a form, I want to
make sure you have set-up everything we will need. WE WILL GO OVER AND
CHECK THIS IN LAB. 

You can work with all of this on your host OS, no need to worry any
longer with the VM. 

Go to https://download.racket-lang.org/ , and download and install the
latest release for your OS and hardware. You may have an older, prior
release. Please unintall your old version and install the most recent.

After (re)installation, open DrRacket.

In the Language menu, you will have to choose "The Racket Language." 

You will next go to the menu File > Install package. You will search
for and install faster-minikanren . 

If you have correctly accomplished these steps, then you will be able
to enter the following in the Definitions window,

#lang racket
(require minikanren)
(run 1 (q) (== q 'cat))


and the green arrow button should work and produce the following

'(cat)

If so, you are properly set-up and configured.

|# 
