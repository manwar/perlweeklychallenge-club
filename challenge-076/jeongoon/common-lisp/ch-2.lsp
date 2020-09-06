;; translated from ch-2.pl
;; ref: https://riptutorial.com/common-lisp/example/11095/conditionally-executing-loop-clauses
;; but I might have a bug it takes more words than my original perl code.
;; or maybe this one is correct...

;; tested with:
;; sbcl --script ch-2.lsp ../data/dict.txt /usr/share/dict/words

(defun get-ridx (mp nc) (floor (/ mp nc)))
(defun all-columns-linear-indices (max-pos num-col)
  (let* ((row-idx (get-ridx max-pos num-col)))
    (loop for c from 0 below num-col collect
          (loop for r from 0 to row-idx
                for p = (+ c (* r num-col))
                if (<= p max-pos) collect p else do(return)))))

(defun all-rows-linear-indices (max-pos num-col)
  (let* ((row-idx (get-ridx max-pos num-col)))
    (loop for r from 0 below row-idx collect
          (let ((base (* r num-col)))
            (loop for c from 0 to num-col
                  for p = (+ base c)
                  if (<= p max-pos) collect p else do(return))))))

(defun all-topleft-bottomright-indices-start-point (max-pos num-col row-idx)
  (let* ((sp1 (loop for c from 0 below num-col collect c))
         (sp2 (loop for e from 1 to row-idx collect (* num-col e))))
    (append sp1 sp2)))

(defun all-topright-bottomleft-indices-start-point (max-pos num-col row-idx)
  (let* ((sp1 (loop for c from 0 below num-col collect c))
         (sp2 (loop for e from 2 to (1+ row-idx) collect (1- (* num-col e)))))
    (append sp1 sp2)))

(defun all-topleft-bottomright-indices (max-pos num-col)
  (let* ((row-idx (get-ridx max-pos num-col))
         (start-point
          (all-topleft-bottomright-indices-start-point
           max-pos num-col row-idx)))
    (loop for s in start-point collect
          (let ((start-col (mod s num-col))
                (rev-result '()))
            (loop for c from 1 below num-col
                  for p = (+ s (* c (1+ num-col)))
                  if (and (<= p max-pos)
                          (< start-col (mod p num-col)))
                  ;; I couldn't do something like below
                  ;; collect p ;; it does ommited some values. have no idea.
                  ;;  why this is happening.. so I used a separted variable
                     do (setq rev-result (cons p rev-result))
                  else do (return))
            (cons s (reverse rev-result))))))

(defun all-topright-bottomleft-indices (max-pos num-col)
  (let* ((row-idx (get-ridx max-pos num-col))
         (start-point
          (all-topright-bottomleft-indices-start-point
           max-pos num-col row-idx)))
    (loop for s in start-point collect
          (let ((start-col (mod s num-col))
                (rev-result '()))
            (loop for c from 1 to start-col
                  for p = (+ s (* c (1- num-col)))
                  if (and (<= p max-pos)
                          (< (mod p num-col) start-col))
                     do (setq rev-result (cons p rev-result))
                  else do (return))
            (cons s (reverse rev-result))))))

(defun flat-once (list-of-list)
  (let ((all (list 'remove-me)))
    (map nil #'(lambda (ls) (nconc all ls)) list-of-list)
    (cdr all)))

(defun all-indices (max-pos num-col)
  (flat-once (loop for f in '(all-columns-linear-indices
                              all-rows-linear-indices
                              all-topleft-bottomright-indices
                              all-topright-bottomleft-indices)
                   collect (funcall f max-pos num-col))))

(defun both-direction (list-of-list)
  (flat-once (map 'list
                  #'(lambda (ls) (if (eq 1 (length ls))
                                (list ls)
                              (list ls (reverse ls)))) list-of-list)))

(defun combi-one (ls) (loop for e in ls collect (list e)))
(defun combi-two (ls)
  ;; we can make combination with simple two next `for' loop but ...
  (let* ((len (length ls))
         (combis (combinations-index 2 len))
         (vec (make-array (list len) :initial-contents ls)))
    (map 'list #'(lambda (a-cb)
                   (loop for i from (first a-cb) to (second a-cb) collect (aref vec i)))
         combis)))

(defun subsequences (list-of-list)
  (flat-once
   (map 'list
        #'(lambda (ls) (if (eq 1 (length ls))
                      (list ls)
                    (append (combi-one ls) (combi-two ls)))) list-of-list)))

;; ( dependencies ... )
(defun make-vector-range (min max)
  (let* ((range (loop for i from min to max collect i))
         (size (length range)))
    (make-array (list size) :initial-contents range)))

(defun combinations-index (n m) ;; from #075
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

(defun filter-string (filter-chr str)
  (coerce (loop for c in (coerce str 'list)
                if (char/= c filter-chr) collect c) 'string))

;; return as (list `number of column' `string **vector** in lower case')
(defun prepare-grid-words (file-path)
  (with-open-file
   (in file-path :if-does-not-exist nil)  ;; return nil instead of error
   (when in
     (let* ((one-line (filter-string #\Space (read-line in nil)))
            (num-col (length one-line)))
       (list num-col ;; first
             (string-downcase
              (apply #'concatenate 'string
                     (coerce one-line 'string)
                     (loop for line = (read-line in nil)
                           while line
                           collect (filter-string #\Space line)))))))))

(defun get-grid-words-list (file-path)
  (let* ((grid-data (prepare-grid-words file-path))
         (num-col (first grid-data))
         (grid-string-vector (second grid-data))
         (max-pos (1- (length grid-string-vector))))
    (map 'list #'(lambda (indcs)
                   (coerce (loop for i in indcs
                                 collect (aref grid-string-vector i)) 'string))
         (both-direction (subsequences (all-indices max-pos num-col))))))

(defun organize-grid-words-list (wls)
  (remove-duplicates (sort wls #'string<) :test #'equal))

(defun get-dictionary-words-list (dict-path)
  (with-open-file
   (in dict-path :if-does-not-exist nil)
   (when in (loop for line = (read-line in nil) while line collect line))))

(defun organize-dictionary-words-list (wls)
  (sort wls #'(lambda (a b) (string< (string-downcase a) (string-downcase b)))))

(defun get-matched-words-list (g-sorted-wlist d-sorted-wlist)
  (let* ((g-len (length g-sorted-wlist))
         (d-len (length d-sorted-wlist))
         (g-vec (make-array (list g-len)
                            :initial-contents g-sorted-wlist))
         (d-vec (make-array (list d-len)
                            :initial-contents d-sorted-wlist))
         (gi 0) (di 0))

    (loop while (and (< gi g-len) (< di d-len))
          for matched = (let* ((g-str (aref g-vec gi))
                               (d-str-orig (aref d-vec di))
                               (d-str (string-downcase d-str-orig)))
                          ;;(format t "~d ~a vs ~d ~a~%" gi g-str di d-str-orig)
                          (if (string< g-str d-str)
                              (progn (setq gi (1+ gi)) nil)
                            (if (string= g-str d-str)
                                (progn (setq gi (1+ gi)) (setq di (1+ di))
                                       d-str-orig)
                              (progn (setq di (1+ di)) nil))))
          when (not (null matched)) collect matched)))


(defun print-grid (dict-path)
  (let ((in (open dict-path :if-does-not-exist nil)))
    (when in
      (loop for line = (read-line in nil)
            while line do (format t "~a~%" line))
      (close in)))) ;; same procedure as with-open-file

(defun get-command-line ()
  (or
   #+CLISP *args*
   #+SBCL *posix-argv*
   #+LISPWORKS system:*line-arguments-list*
   #+CMU extensions:*command-line-words*
   nil))

(defparameter *cmdline* (get-command-line))

(defun print-usage ()
  (format t "Usage: sbcl --script ch-1.lsp <grid file> <dictionary file>"
          (first *cmdline*)))

(when (< (length *cmdline*) 3) (print-usage) (quit))
(defparameter *grid-file-path* (second *cmdline*))
(defparameter *dict-file-path* (third *cmdline*))

(print-grid *grid-file-path*)
(defvar *grid-words-list*
  (organize-grid-words-list (get-grid-words-list *grid-file-path*)))

(format t "Total ~d possible word(s) in the grid.~%" (length *grid-words-list*))

(defvar *dict-words-list*
  (organize-dictionary-words-list (get-dictionary-words-list *dict-file-path*)))

;;(format t "~a~%" *dict-words-list*)

(defvar *matched-words-list*
  (get-matched-words-list *grid-words-list* *dict-words-list*))

(format t "~a~%" *matched-words-list*)
(format t "Total ~d word(s) matched.~%" (length *matched-words-list*))

;;(format t "~a~%" (all-columns-linear-indices 75 4))
;;(format t "~a~%" (all-rows-linear-indices 75 4))
;;(format t "~a~%" (all-topleft-bottomright-indices-start-point 75 4 (get-ridx 75 4)))
;;(format t "~a~%" (all-topleft-bottomright-indices 75 4))
;;(format t "~a~%" (all-topright-bottomleft-indices-start-point 75 4 (get-ridx 75 4)))
;;(format t "~a~%" (all-topright-bottomleft-indices 75 4))
;;(format t "~a~%" (all-indices 75 4))
;;(format t "~a~%" (both-direction (all-columns-linear-indices 75 4)))
;;(format t "~a~%" (subsequences (all-indices 75 4)))
;;(defvar *test* (prepare-grid-words *grid-file-path*))
;;(format t "~a~%" *test*)
