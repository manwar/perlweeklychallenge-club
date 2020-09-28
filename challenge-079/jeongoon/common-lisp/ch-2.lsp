;; ( solution ... )
(defun max-list (a-list)
  (let* ((cur-max)
         (size (length a-list)))
    (loop for x in a-list collect
          (if (or (null cur-max) (< cur-max x)) (setq cur-max x) cur-max))))

(defun haskell/init (a-list) (reverse (rest (reverse a-list))))

(defun trapped-water-data (histogram-data)
  (let* ((histo-size (length histogram-data))
         (lefts (rest (max-list (haskell/init histogram-data))))
         (rights (reverse (rest (max-list (reverse (rest histogram-data))))))
         (mids  (haskell/init (rest histogram-data)))
         (waters-only (map 'list (lambda (l m r) (- (min l r) m)) lefts mids rights)))
    (cons 0 (nconc waters-only '(0)))))

;; modified from ch-075 :: ch-2.lsp
(defun print-histogram-with-water (histogram-data water-data)
  (let* ((histogram-size (length histogram-data))
         (max-height (apply #'max histogram-data))
         (word-width (1+ (length (format nil "~d" max-height))))
         (fmt-string (format nil "~~~d@a" word-width)))

    (loop for y from max-height downto 1 collect
          (let* ((line (format nil fmt-string y)) ;; first column: y scale
                 )
            ;; whitespace or sharpmark
            (map nil
                 (lambda (x-data w-data)
                   (let* ((current-word
                           (format nil fmt-string
                                   (if (>= x-data y) "#"
                                     (if (>= (+ x-data w-data) y) "~"
                                       "")))))
                     (setq line(concatenate 'string line current-word))))
                 histogram-data water-data)
            (format t "~a~%" line)
            line))
    (format t "~a~%" (make-string (* word-width (1+ histogram-size))
                                  :initial-element #\_))
    (format t fmt-string "")
    (map nil
         #'(lambda (x-data) (format t fmt-string x-data)) histogram-data)
    (format t "~%")))

; ( testing ... )
(defun get-command-line ()
  (or
   #+CLISP *args*
   #+SBCL *posix-argv*
   #+LISPWORKS system:*line-arguments-list*
   #+CMU extensions:*command-line-words*
   nil))

(defparameter *cmdline* (get-command-line))

(defun print-usage ()
  (format t "Usage: sbcl --script ch-2.lsp <at least three histogram data> ..."
          (first *cmdline*)))

(when (< (length *cmdline*) 4) (print-usage) (quit))
(defparameter *histogram-data* (map 'list #'parse-integer (rest *cmdline*)))
;;(format t "~a~%" *histogram-data*)
(defvar *water-data* (trapped-water-data *histogram-data*))
(format t "Total capacity: ~a~%" (reduce '+ *water-data*))
(print-histogram-with-water *histogram-data* *water-data*)
