;; ( solution ... )
;; which depends on combinations function
(defun get-largest-rect-area (histogram-data)
  (let*
      ((histogram-size (length histogram-data))
       (all-possible-area
        (append
         histogram-data ;; by size of width 1
         (map 'list
              #'(lambda (pos)
                  (let* ((x1 (apply #'min pos)) ;; ensure x1 < x2
                         (x2 (apply #'max pos))
                         (common-height
                          (apply #'min (subseq histogram-data x1 (1+ x2)))))
                    (* common-height (1+ (- x2 x1)))))
              (combinations-index 2 histogram-size)))))
    (apply #'max all-possible-area)))

;; ( bonus ... )
(defun print-histogram (histogram-data)
  (let* ((histogram-size (length histogram-data))
         (max-height (apply #'max histogram-data))
         (word-width (1+ (length (format nil "~d" max-height))))
         (fmt-string (format nil "~~~d@a" word-width)))

    (loop for y from max-height downto 1 collect
          (let* ((line (format nil fmt-string y)) ;; first column: y scale
                 )
            ;; whitespace or sharpmark
            (map nil
                 #'(lambda (x-data)
                     (let* ((current-word
                             (format nil fmt-string
                                     (if (< x-data y) "" "#"))))
                       (setq line(concatenate 'string line current-word))))
                 histogram-data)
            (format t "~a~%" line)
            line))
    (format t "~a~%" (make-string (* word-width (1+ histogram-size))
                                  :initial-element #\_))
    (format t fmt-string "")
    (map nil
         #'(lambda (x-data) (format t fmt-string x-data)) histogram-data)
    (format t "~%")))

;; ( dependecies ... )
(defun make-range (minv maxv &optional (step 1)) ;; from #072
  (when (<= minv maxv)
    (cons minv (make-range (+ minv step) maxv step))))

(defun make-vector-range (min max &optional (step 1))
  (let* ((range (make-range min max step))
         (size (length range)))
    (make-array (list size) :initial-contents range)))

(defun combinations-index (n m) ;; translated from ch-2.pl
  ;; a non-recursive method for making combinations
  (when (>= m n)
    (let* ((initial-room-size (- m n))
           (room (make-array (list n) :initial-element initial-room-size))
           (pos  (make-array (list n)
                             :initial-contents (make-vector-range 0 (1- n))))
           (next-cursor (1- n))
           (combi (list (coerce pos 'list)))) ;; coerce makes a copy of array
      (loop named moving-element do
            (if (> (aref room next-cursor) 0)
                ;; still current element move to right
                (let ((ref-room (aref room next-cursor))
                      (ref-pos  (aref pos  next-cursor)))
                  (setf (aref room next-cursor) (1- ref-room))
                  (setf (aref pos  next-cursor) (1+ ref-pos))
                  (nconc combi (list (coerce pos 'list))))
              ;; else
              ;; no more room left on the right for current element
              ;; have to move cursor to point next avaiable one.
              (let*
                  ((cursor-moved
                    (loop named moving-cursor for i from next-cursor above 0
                          do
                          (when (> (aref room (1- i)) 0)
                            (setq next-cursor (1- i))
                            (return-from moving-cursor t)))))
                (if cursor-moved
                    (let ((room-size (1- (aref room next-cursor)))
                          (base-pos  (aref pos next-cursor)))
                      (loop for i from next-cursor below n
                            for p from 1 do
                            (progn
                              (setf (aref room i) room-size)
                              (setf (aref pos  i) (+ base-pos p))))
                      (nconc combi (list (coerce pos 'list)))
                      (setq next-cursor (1- n)))
                  ;; else : "no more movement" means we found all combinations
                  (return-from moving-element combi))))))))

;; ( testing ... )
(defun get-command-line ()
  (or
   #+CLISP *args*
   #+SBCL *posix-argv*
   #+LISPWORKS system:*line-arguments-list*
   #+CMU extensions:*command-line-words*
   nil))

(defparameter *cmdline* (get-command-line))

(defun print-usage ()
  (format t "Usage: sbcl --script ch-2.lsp <at least one histogram data> ..."
          (first *cmdline*)))

(when (< (length *cmdline*) 2) (print-usage) (quit))

(defparameter *histogram-data* (map 'list #'parse-integer (cdr *cmdline*)))
(format t "Input: @A = ~A~%" *histogram-data*)
(format t "Ouput: ~d~%" (get-largest-rect-area *histogram-data*))
(print-histogram *histogram-data*)
