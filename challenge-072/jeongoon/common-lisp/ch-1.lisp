;; Ref:
;; http://www.ai.mit.edu/projects/iiip/doc/CommonLISP/HyperSpec/Body/fun_map.html
;; https://stackoverflow.com/questions/47602677/recursive-factorial-function-in-common-lisp
;; https://stackoverflow.com/questions/22522108/how-to-map-a-function-in-common-lisp
;; https://stackoverflow.com/questions/1021778/getting-command-line-arguments-in-common-lisp
;; https://riptutorial.com/common-lisp/example/8770/summing-a-list
;; https://www.tutorialspoint.com/lisp/lisp_strings.htm

(defun my-command-line ()
  (or
   #+CLISP *args*
   #+SBCL *posix-argv*
   #+LISPWORKS system:*line-arguments-list*
   #+CMU extensions:*command-line-words*
   nil))

(defun range (min max &optional (step 1))
  (when (<= min max)
    (cons min (range (+ min step) max step))))

(defun factorial (n)
  (if (= n 1)
      1
    (* n (factorial (- n 1)))))

(defun nth-root-of-five (x)
  (if (= (mod x 5) 0)
      (+ 1 (nth-root-of-five (/ x 5)))
    0 ))

(defun get-answer (n)
  (let ((seq (range 1 n)))
    (reduce '+ (map 'list #'nth-root-of-five (range 1 n)))))

(defun show-divided-number(n prompt answer)
  (let* ((str (write-to-string n))
         (needle (- (length str) answer 1))
         (str-left (subseq str 0 needle))
         (str-right (subseq str (+ needle 1))))
    (format t "~a~a | ~a~%" prompt str-left str-right)))

(progn
  (let* ((cmd-line (my-command-line))
         (n (parse-integer (nth 1 cmd-line)))
         (answer (get-answer n)))
    (format t "N:  ~a~%" n)
    (show-divided-number (factorial n) "N!: " answer)
    (format t "~%Answer: ~a~%" answer)))
