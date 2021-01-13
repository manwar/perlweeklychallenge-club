;; Ref:
;; http://cl-cookbook.sourceforge.net/loop.html
;; http://clhs.lisp.se/Body/f_mk_ar.htm
;; https://stackoverflow.com/questions/3950601/swapping-elements-in-a-common-lisp-list
;; http://clhs.lisp.se/Body/v_rnd_st.htm#STrandom-stateST
;; https://stackoverflow.com/questions/13359025/adding-to-the-end-of-list-in-lisp

;; I've done with array not list -- which seems wrong choice...

;; tested with
;; sbcl --script ch-1.lsp <number>

(defun get-command-line () ;; from #072
  (or
   #+CLISP *args*
   #+SBCL *posix-argv*
   #+LISPWORKS system:*line-arguments-list*
   #+CMU extensions:*command-line-words*
   nil))

(defun get-random-pairs (n)
  (let ((*random-state* (make-random-state t)))
       (loop for cnt from 1 to n
             collect (list (random n) (random n)))))

(defun make-range (minv maxv &optional (step 1)) ;; from #072
  (when (<= minv maxv)
    (cons minv (make-range (+ minv step) maxv step))))

(defun make-vector-range (min max &optional (step 1))
  (let* ((range (make-range min max step))
         (size (length range)))
    (make-array (list size) :initial-contents range)))

;; not used here
(defun minimum-in-vector (arr &optional (i 0))
  (let ((j (+ i 1)))
    (if (= (length arr) j)
        (aref arr i)
      ;; else
      (when (> (length arr) j)
        (min (aref arr i) (minimum-in-vector arr j))))))

(defun shuffle-array-by-swapping (arr)
  (let* ((size (length arr))
         (shuffle-pairs (get-random-pairs size)))
    (loop for pair in shuffle-pairs
          do (let ((le (first pair)) (ri (second pair)))
               (when (not (and (null le) (null ri)))
                 ;; rotatef: change in place ; I think *f means put in pyhsical memory
                 (rotatef (aref arr le) (aref arr ri)))))))

;; tranlated from groupMinimumList in perl/ch-1.pl
(defun group-minimum-list (arr group-size)
  (let* ((total-size     (length arr))
        (min-val        nil)
        (idx-init       (- 1 group-size))
        (idx-max        (- total-size group-size))
        (idx-memo       -1)
        (result         ()))

    (loop for b from 0 below total-size  ;; b:index for value to be checked
                                         ;;   or last  index in the gorup
          do (let* ((idx (+ idx-init b)) ;; idx: first index in the group
                    (idx-memo-inboundp (> idx-memo idx))
                    (group-inboundp (and (<= 0 idx) (<= idx idx-max)))
                    (cur-val (aref arr b)))

               (if (and group-inboundp (not idx-memo-inboundp))
                   ;; compare everything in the group
                   (progn
                     (setq idx-memo idx) ;; restart from first index in the grp
                     (setq min-val (aref arr idx))
                     (loop for d from 1 below group-size
                           do(let* ((j (+ idx d))
                                    (cur-val (aref arr j)))
                               (when (>= min-val cur-val)
                                 (setq idx-memo j)
                                 (setq min-val cur-val)))))
                 ;; else
                 (when (or (null min-val) (<= cur-val min-val))
                   (setq min-val cur-val)
                   (setq idx-memo b)) ;; *real index* in the list not idx
                 )

               (when group-inboundp
                 (if (null result)
                     (setq result (list min-val))
                   (nconc result (list min-val))))))
    result ))

(defparameter *cmdline* (get-command-line))

(defun print-usage ()
  (format t "Usage: sbcl --script ch-1.lsp <sliding-size>" (car *cmdline*)))

(when (not (= (length *cmdline*) 2))
  (format t "Wrong Number of arguments: expected 1: but got: ~d~%" (- (length *cmdline*) 1))
  (print-usage)
  (quit))

;; *slide-size*
(defparameter *slide-size* (parse-integer (second *cmdline*)))

(when (< *slide-size* 3)
  (format t "Too short slide size: ~d: using 3~%" *slide-size*)
  (setq *slide-size* 3))

;; *frame-size* ; which is 3 times larger than slide at least
(defparameter *frame-size* (* 10 (round (* 0.3 *slide-size*) 1)))

(format t "Frame Size: ~d~%Slide Size: ~d~%" *frame-size* *slide-size*)

(defparameter *example* (make-vector-range 0 (- *frame-size* 1)))
(shuffle-array-by-swapping *example*)
(format t "Input: ~S~%" *example*) ;; used array not list :-/
(defvar result (group-minimum-list *example* *slide-size*))
(format t "Output: ~S~%" result)
