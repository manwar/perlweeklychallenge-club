;; Ref:

;; tested with
;; sbcl --script ch-2.lsp <number>

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

(defun shuffle-array-by-swapping (arr)
  (let* ((size (length arr))
         (shuffle-pairs (get-random-pairs size)))
    (loop for pair in shuffle-pairs
          do (let ((le (first pair)) (ri (second pair)))
               (when (not (and (null le) (null ri)))
                 ;; rotatef: change in place ; I think *f means put in pyhsical memory
                 (rotatef (aref arr le) (aref arr ri)))))))

;; tranlated from groupMinimumList in perl/ch-1.pl
(defun smallest-or-zero-list (arr)
  (let* ((size (length arr))
         (smallest))

    (loop for i from 0 below size
          collect
          (let ((cur-val (aref arr i)))
            (if (null smallest)
                (progn (setq smallest cur-val) 0)
              ;; else
              (if (< cur-val smallest)
                  (progn (setq smallest cur-val) 0) smallest ))))))

(defparameter *cmdline* (get-command-line))

(defun print-usage ()
  (format t "Usage: sbcl --script ch-1.lsp <list-size>" (car *cmdline*)))

(when (not (= (length *cmdline*) 2))
  (format t "Wrong Number of arguments: expected 1: but got: ~d~%" (- (length *cmdline*) 1))
  (print-usage)
  (quit))

;; *size*
(defparameter *size* (parse-integer (second *cmdline*)))

(when (< *size* 5)
  (format t "Too short slide size: ~d: using 5~%" *size*)
  (setq *size* 5))

(format t "Size: ~d~%" *size*)

(defparameter *example* (make-vector-range *size* (- (* 2 *size*) 1)))
(shuffle-array-by-swapping *example*)
(format t "Input: ~S~%" *example*)
(defvar result (smallest-or-zero-list *example*))
(format t "Output: ~S~%" result)

