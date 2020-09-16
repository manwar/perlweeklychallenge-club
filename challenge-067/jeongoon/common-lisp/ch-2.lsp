;; from ch-077/ch-1.lsp

(defun flat-once (list-of-list)
  (let ((all '()))
    (map nil #'(lambda (ls) (setq all (append all ls))) list-of-list)
    all))

;; get a list of vectors
;; each vector has all the possible cases and this function will
;; product the all the cases by going through
;; this function is a non-recursive implementation of product the cases
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


(defun get-command-line ()
  (or
   #+CLISP *args*
   #+SBCL *posix-argv*
   #+LISPWORKS system:*line-arguments-list*
   #+CMU extensions:*command-line-words*
   nil))

(defparameter *cmdline* (get-command-line))

(defun print-usage ()
  (format t "Usage: sbcl --script ch-1.lsp <$S> # ex) 35"
          (first *cmdline*)))

(when (< (length *cmdline*) 2) (print-usage) (quit))
(defparameter *numbers-to-change* (second *cmdline*))
(defparameter *letter-phone-hash* (make-hash-table))
;; generating letter phone dial pad to lookup
(mapcar (lambda (c v) (setf (gethash (intern (string c)) *letter-phone-hash*) v))
        (coerce "0123456789*#" 'list)
        '("" "_,@" "abc" "def" "ghi" "jkl" "mno" "pqrs" "tuv" "wxyz" " " ""))

(defvar cases-map
  (loop for num-char in (coerce *numbers-to-change* 'list)
        collect (let* ((sym (intern (string num-char)))
                       (candi-lst (coerce (gethash sym *letter-phone-hash*) 'list)))
                  (make-array (list (length candi-lst))
                              :initial-contents
                              ;; product-case function will get
                              ;; a list of vectors, each vector has to get
                              ;; all the lists which contain a possible case
                              ;; which canbe a simple character or a list
                              ;; e.g) #(("a case") ("b case")) or
                              ;; #((1 2 3) (4 5))
                              (map 'list (lambda (a-char) (list a-char)) candi-lst)))))

;;(format t "~a~%" cases-map)
(format t "[~{\"~a\"~^, ~}]~%" (map 'list (lambda (a-case) (coerce a-case 'string))
                      (product-cases cases-map)))
