;; translated from ch-1.pl
;; tested with:
;; sbcl --script ch-1.lsp 99999
;; (finished under 0.3 seconds)
;; common-lisp was winner in my implementation

;; fibonacci number in reverse order upto limit
(defun rfibs (limit) ;; ignore first number 1 for challenge purpose
  (if (= limit 1) (list 1)
    (if (= limit 2) (list 2 1)
      (let ((rfib (list 2 1)))
        (loop for nf = (+ (car rfib) (cadr rfib))
              if (<= nf limit) do (setq rfib (cons nf rfib))
              else do (return))
        rfib))))

;;(format t "~a~%" (rfibs 100))

(defun a-fib-sub-cases (a-fib rfibs-ls) ;; return as a vector of lists
  (let* ((skip 0)
        (rlen (length rfibs-ls))
        (rfibs-vec (make-array (list rlen) :initial-contents rfibs-ls)))
    (setq skip (loop named finding-idx for i from 0 below rlen
                     for a-rf = (aref rfibs-vec i)
                     if (= a-rf a-fib) do (return-from finding-idx i)))
    (if (null skip)
        '()
      (let* ((sub-rfib-len (- rlen skip))
             (all-cases (list (list a-fib))))
        (loop named generating-subfib
              for i  from 0 below (- sub-rfib-len 2) by 2
              for ri = (+ skip i 1)
              do (let* ((last-fibs (car (last all-cases))) ;; XXX car needed
                        (two-fibs (list (aref rfibs-vec ri)
                                        (aref rfibs-vec (1+ ri))))
                        (last-fibs-withouth-last-one
                         (reverse (cdr (reverse last-fibs))))
                        (new-sub-case
                         (append last-fibs-withouth-last-one two-fibs)))

                   (nconc all-cases (list new-sub-case))))
        (make-array (list (length all-cases)) :initial-contents all-cases)))))

;;(format t "~a~%"  (a-fib-sub-cases 55 (rfibs 55)))

(defun flat-once (list-of-list)
  (let ((all '()))
    (map nil #'(lambda (ls) (setq all (append all ls))) list-of-list)
    all))

(defun product-cases (cases-map &optional validate-func)
  (let* ((num-cases (length cases-map))
         (cases-vec (make-array (list num-cases) :initial-contents cases-map))
         (pos (make-array (list num-cases) :initial-element 0))
         (csr (1- num-cases)) ;; pointing the last case
         (all-cases (list 'remove-me)))

    (loop named processing-cases do
          (if (< (aref pos csr) (length (aref cases-vec csr)))
              ;; still have next step at the current cursor
              (let* ((cur-cases-combi
                      (mapcar
                       (lambda (sub-case cur-sub-case-idx)
                         (coerce (aref sub-case cur-sub-case-idx) 'list))
                       cases-map (coerce pos 'list))))

                (when (or (null validate-func)
                          (funcall validate-func cur-cases-combi))
                  ;; flatten and collect the case
                  (nconc all-cases (list (flat-once cur-cases-combi))))
                ;; try next case
                (setf (aref pos csr) (1+ (aref pos csr))))
            ;; else -- try to go higher order
            (let* ((new-csr
                    (loop named finding-new-cursor
                          for c from (1- csr) downto 0
                          if (< (aref pos c) (1- (length (aref cases-vec c))))
                          do (return-from finding-new-cursor c))))
              (if (null new-csr)
                  (return-from processing-cases)
                (progn
                  (setf (aref pos new-csr) (1+ (aref pos new-csr)))
                  (loop for i from (1+ new-csr) below num-cases
                        do (setf (aref pos i) 0))
                  (setq csr (1- num-cases)))))))
    (cdr all-cases)))


;; (format t "~a~%"  (product-cases (list (a-fib-sub-cases 55 (rfibs 55))
;;                                        (a-fib-sub-cases 13 (rfibs 13)))))

(defun product-a-rfibs-combi (a-fibs-combi rfibs-ls) ;; `r' means reversed order
  (let* ((rcase-map (map 'list
                      (lambda (a-fib) (a-fib-sub-cases a-fib rfibs-ls))
                      a-fibs-combi)))
    (product-cases rcase-map
                   (lambda (a-combi) ;; validation code
                     (let* ((left-case (first a-combi))
                            (overlapped
                             (loop named finding-duplicated
                                   for right-case in (cdr a-combi)
                                   if (<= (car (last left-case)) (first right-case))
                                   do (return-from finding-duplicated t)
                                   else
                                   do (setq left-case right-case))))
                       (not overlapped))))))

;;(format t "~a~%" (product-a-rfibs-combi '(55 13 5) (rfibs 55)))

(defun a-min-combi-rfib-sum (target-sum rfibs-ls)
  (let ((major-fib
         (loop named finding-major-fib for a-fib in rfibs-ls
               do (if (<= a-fib target-sum)
                      (return-from finding-major-fib a-fib)
                    (setq rfibs-ls (cdr rfibs-ls))))))
    (if (null major-fib)
        '()
      ;;
      (if (= major-fib target-sum)
          (list major-fib)
        (let ((rest-fibs (a-min-combi-rfib-sum
                          (- target-sum major-fib) rfibs-ls)))
          (if (null rest-fibs)
              '()
            (cons major-fib rest-fibs)))))))

;;(format t "~a~%" (a-min-combi-rfib-sum 100 (rfibs 100)))

;; final solution form
(defun all-combi-fib-sum (target-sum)
  (let* ((rfibs-ls (rfibs target-sum))
         (a-sum-combi (a-min-combi-rfib-sum target-sum rfibs-ls)))
    (if (null a-sum-combi)
        '()
      (product-a-rfibs-combi a-sum-combi rfibs-ls))))

(defun get-command-line ()
  (or
   #+CLISP *args*
   #+SBCL *posix-argv*
   #+LISPWORKS system:*line-arguments-list*
   #+CMU extensions:*command-line-words*
   nil))

(defparameter *cmdline* (get-command-line))

(defun print-usage ()
  (format t "Usage: sbcl --script ch-1.lsp <target-sum>"
          (first *cmdline*)))

(when (< (length *cmdline*) 2) (print-usage) (quit))
(defparameter *target-sum* (parse-integer (second *cmdline*)))
(format t "Input: ~d~%Output:~%" *target-sum*)
(defvar all-combi (all-combi-fib-sum *target-sum*))
(map nil (lambda (a-combi)
           (progn (format t "~{~a~^ + ~}" a-combi)
                  (format t " = ~a~%" *target-sum*))
           ) all-combi)

(format t "Total ~d case(s) found.~%" (length all-combi))
