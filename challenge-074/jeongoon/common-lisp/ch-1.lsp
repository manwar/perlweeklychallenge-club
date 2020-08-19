;; tested with:
;; sbcl --script ch-1.lsp 10

;; ( solution ... )
(defun get-major (arr)
  (let* ((sorted-copied (sort (copy-seq arr) #'<))
         (result)
         (len (length sorted-copied))
         (half-len (floor (length sorted-copied) 2))
         (prev-num (aref sorted-copied 0))
         (prev-cnt 1))

    (setq result
          (loop named finding-major for i from 1 below len
                do
                (progn
                  (if (= prev-num (aref sorted-copied i))
                      (if (= prev-cnt half-len)
                          (return-from finding-major (aref sorted-copied i))
                        ;; else
                        (setq prev-cnt (+ prev-cnt 1)))
                      ;; else
                      (progn (setq prev-num (aref sorted-copied i))
                             (setq prev-cnt 1))))))

    (if (null result) -1 result)))

;; ( testing ... )
(defun get-command-line () ;; from #072
  (or
   #+CLISP *args*
   #+SBCL *posix-argv*
   #+LISPWORKS system:*line-arguments-list*
   #+CMU extensions:*command-line-words*
   nil))

(defun a-random (n)
  (let ((*random-state* (make-random-state t)))
    (random n)))

(defun get-random-pairs (n)
  (let ((*random-state* (make-random-state t)))
       (loop for cnt from 1 to n
             collect (list (random n) (random n)))))

(defun shuffle-array-by-swapping (arr)
  (let* ((size (length arr))
         (shuffle-pairs (get-random-pairs size)))
    (loop for pair in shuffle-pairs
          do (let ((le (first pair)) (ri (second pair)))
               (when (not (and (null le) (null ri)))
                 ;; rotatef: change in place ; I think *f means put in pyhsical memory
                 (rotatef (aref arr le) (aref arr ri)))))))

(defparameter *cmdline* (get-command-line))

(defun print-usage ()
  (format t "Usage: sbcl --script ch-1.lsp <size-of-list>" (first *cmdline*)))

(when (not (= (length *cmdline*) 2)) (print-usage) (quit))

(defparameter *size* (parse-integer (second *cmdline*)))
(defparameter *ensure-major*
  (let ((*random-state* (make-random-state t))
        (a-num (random *size*)))
    (if (evenp a-num) t nil)))
(defparameter *major-num*
  (when *ensure-major* (a-random *size*)))

(defparameter *sample* (make-array (list *size*)))
;; generate *sample*
(let* ((major-len (floor *size* 2))
       (break-point 0))
  (when *ensure-major*
    (loop for i from 0 to major-len
          do (setf (aref *sample* i) *major-num*))
    (setq break-point major-len))
  (loop for i from break-point below *size*
        do (setf (aref *sample* i) (a-random *size*))))
(shuffle-array-by-swapping *sample*) ;; note: change in place

(format t "Input: ~S~%" *sample*)
(defvar result (get-major *sample*))
(format t "Output: ~d~%" result)

;; Ref: http://clhs.lisp.se/Body/f_sort_.htm
;;      https://www.tutorialspoint.com/lisp/lisp_arrays.htm
;;      http://clhs.lisp.se/Body/f_random.htm
;;      http://clhs.lisp.se/Body/f_cp_seq.htm
