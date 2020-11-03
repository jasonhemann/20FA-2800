#| 

Lab 9 

|# 

;; Only two problems. They are thinkers. 

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


;; 2. The Church-Rosser Theorem in an ACL2-ish prover

;; At the URL
;; https://libkey.io/libraries/545/articles/15438718/full-text-file?utm_source=api_57
;; (reached from NEU via
;; https://onesearch.library.northeastern.edu/permalink/f/t09un1/TN_cdi_gale_infotracacademiconefile_A6895045)
;; you will find a JACM paper describing a mechanized proof of the
;; Church-Rosser theorem.

;; You do not have to read this in its entirety, or even most of it.

;; You do not have to limit your reading to this paper; in fact there
;; are scores of better places to start learning about the material
;; foundational to understanding this paper.

;; But I want you to _see_ a non-trivial ACL2(-like) proof, and a
;; published work about it.

;; a) What is the Church-Rosser theorem? Give it to me in about a
;; paragraph. Assume Statement 3.1 is completely incomprehensible to
;; me, but assume further that I'd understand it if I started at the
;; beginning of the paper and methodically worked my way there.




;; b) Skim pages 508-522. Find some a theorem or definition in there
;; that seems approachable given what you have learned from ACL2S and
;; 2800, and explain what you think it's doing. If you can explain
;; *where* it shows up in the context of the overall proof, that's
;; even better, but I'm not even requiring that. 

