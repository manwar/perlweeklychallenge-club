;;; To run this programme; you will need to install quicklisp
;; about quicklisp:
;; -> https://www.quicklisp.org/beta/
;; follow steps describe in above and rest of code will run.

;; ----------------------------------------------------------------
;; tested with:
;; sbcl --script ch-1.lsp 0.1 2.2 0.3 0.5 1.4 0.75
;; ----------------------------------------------------------------


;; copied from ~/.sbclrc
#-quicklisp
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (if (probe-file quicklisp-init)
      (load quicklisp-init)
    (progn (format t "please install quicklisp:https://www.quicklisp.org/beta/")
           (quit))))

;;; there was no default parse-float *SIGH*
;; https://lispcookbook.github.io/cl-cookbook/numbers.html#reading-numbers-from-strings
(ql:quickload :parse-float :silent t)
(use-package :parse-float)
;; example:
;(defvar x (parse-float "23.4e2" :type 'double-float))
;(format t "~A" x)


;; ----------------------------------------------------------------
;; Combinations Generator (making case one by one)
;; ----------------------------------------------------------------
;; we don't really need here because making combinations with selection of 3,
;; can be done by multiple loop
;; but I've just rebuilt it for general purpose.

(defstruct ci
  dlen ; data length
  nsel ; number of selection
  ncsr ; next cursor
  room ; room left for each selection on their right hand side
  pos  ; current position of each selection
  )

(defun make-vector-range (min max)
  (let* ((range (loop for i from min to max collect i))
         (size (length range)))
    (make-array size :initial-contents range)))

(defun make-combi-index-iter (c s) ; (c -> choice, s -> selection)
  ;; another trying to make non-recursive combination with iterator
  (when (>= c s)
    (let* ((initial-room-size (- c s))
           (room (make-array s
                             :initial-element initial-room-size
                             :fill-pointer (1- s)))
           (pos  (make-array s
                             :initial-contents
                             (concatenate 'vector
                                          (make-vector-range 0 (- s 2))
                                          ;; last element should go backward ...
                                          (vector (- s 2)))))
           (next-cursor (1- s)))
      ;; last element should go backward for the first case
      (vector-push (1+ initial-room-size) room)
      (make-ci :dlen c :nsel s :ncsr next-cursor :room room :pos pos))))

(defun next-indices (it)
  (let* ((csr_ (ci-ncsr it))
         (room (ci-room it))
         (pos  (ci-pos  it)))
    (if (> (aref room csr_) 0)
        ;; still current element is able to move to right
        (progn
          (decf (aref room csr_))
          (incf (aref pos  csr_))
          (coerce pos 'list)) ;; vector -> list; also does copy
      ;; else
      ;; no more room left on the right hand side for current element
      ;; need to move cursor to point next avaiable one.
      (let*
          ((cursor-moved
            (loop named moving-cursor for i from csr_ above 0
                  do
                  (when (> (aref room (1- i)) 0)
                    (setf csr_ (1- i))
                    (return-from moving-cursor t)))))
        (if cursor-moved
            (let* ((s (ci-nsel it))
                   (room-size (1- (aref room csr_)))
                   (base-pos  (aref pos csr_)))
                 (loop for i from csr_ below s
                       for p from 1 do
                       (progn
                         (setf (aref room i) room-size)
                         (setf (aref pos  i) (+ base-pos p))))
                 (setf (ci-ncsr it) (1- s))
                 (coerce pos 'list))
          nil)))))

(defun get-command-line ()
  (or
   #+CLISP *args*
   #+SBCL *posix-argv*
   #+LISPWORKS system:*line-arguments-list*
   #+CMU extensions:*command-line-words*
   nil))

(defparameter *cmdline* (get-command-line))

(defun print-usage ()
  (format t "Usage: sbcl --script ch-1.lsp <real numbers> ...(at least three numbers)"
          ;;(first *cmdline*)
          ))

(when (< (length *cmdline*) 4) (print-usage) (quit))

(defparameter *triplet-candis* (map 'list #'parse-float (rest *cmdline*)))
(format t "original list:~%~A~%" *triplet-candis*)
(defvar *tidy-candis* (coerce (sort (remove 2.0 *triplet-candis* :test #'<) #'<)
                              'vector))

(format t "useful sorted list(vector):~%~A~%~%" *tidy-candis*)
(defvar *it* (make-combi-index-iter (length *tidy-candis*) 3))

;; ----------------------------------------------------------------
;; ENTRY POINT
;; ----------------------------------------------------------------
(loop
 (let ((ids (next-indices *it*)))
   (if ids
       (let* ((trs (loop for i in ids collect(aref *tidy-candis* i)))
              (trs-sum (apply #'+ trs)))
         (when (< 1.0 trs-sum 2.0)
           (format t "1 as 1.0 < (~{~d~^ + ~} = ~A) < 2.0~%" trs trs-sum)
           (return)))
     ;; finish all combination but could not find
     (progn
       (format t "0~%")
       (return)))))
