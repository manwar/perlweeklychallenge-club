;; 1. sort and delete-duplicates the copy of sequence
;; 2. while traversing sublist of original data from the beginning
;     a. reverse the sublist
;;    b. find each character from the original data twice (a)
;;    c. if the character found only once (NR :Not Repeating)
;;       make the pair of (character, length of right hand side result)
;;    d. if the length is less than previous one, replace orginal data,
;;       else leave it
;; 3. if we have record return the the character, or return '#'

;; tested with:
;; sbcl --script ch-2.lsp xyzzyx

;; ( solution ... )
(defun get-lnr-string (str)
  (coerce (get-lnr-char-list str) 'string))

(defun get-lnr-char-list (str)
  ;; 1.
  (let* ((sorted-copied-uniq
          ;; #'remove-duplicates -> make a *copy*
          ;; #'sort              -> change applied *in place*
          (sort (remove-duplicates str) #'char-lessp))
          (str-len (length str)))

    ;; 2.
    (loop for i from 0 below str-len
          ;; (subseq *seq* start-index &optional end-index) ;; end *exclusive*
          collect (let* ((sub-len (+ i 1))
                         (sub-str (subseq str 0 sub-len))
                         (record '()))
                    (loop for ch in (coerce sorted-copied-uniq 'list)
                          do (let* ((ch-str (list ch)) ;; for #'search
                                    (pos1 ;; first one found from the end
                                     (search ch-str sub-str :from-end t)))
                               (when (not (null pos1))
                                 (let* ((pos2 ;; second one:
                                         ;; the char already duplicated
                                         (search ch-str sub-str
                                                 :end2 pos1 :from-end t)))
                                   (when (null pos2) ;; NR
                                     (let ((rlength (- str-len pos1 1)))
                                       (when (or (null record)
                                                 (< rlength (cdr record)))
                                         (setq record (cons ch-str rlength)))))))))
                    ;; 3.
                    (if (null record) #\# (caar record))))))

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
  (format t "Usage: sbcl --script ch-2.lsp xueuxsnlejepkfx" (first *cmdline*)))

(when (not (= (length *cmdline*) 2))
  (format t "Wrong Number of arguments: expected 1: but got: ~d~%" (- (length *cmdline*) 1))
  (print-usage)
  (quit))

(defparameter *sample-string* (string (second *cmdline*)))

(format t "Input:  ~S~%" *sample-string*)
(defvar fnr-string (get-lnr-string *sample-string*))
(format t "Output: ~S~%" fnr-string)

;; Ref: https://millsroboticsteam253.com/the-common-lisp-cookbook-data-structures/
;; http://clhs.lisp.se/Body/f_subseq.htm
;; http://clhs.lisp.se/Body/f_coerce.htm#coerce

;; ----------------------------------------------------------------
;; TASK #2 › FNR Character
;; Submitted by: Mohammad S Anwar

;; You are given a string $S.

;; Write a script to print the series of first non-repeating character (left -> right) for the given string. Print # if none found.
;; Example 1
;; Input: $S = ‘ababc’
;; Output: ‘abb#c’
;; Pass 1: “a”, the FNR character is ‘a’
;; Pass 2: “ab”, the FNR character is ‘b’
;; Pass 3: “aba”, the FNR character is ‘b’
;; Pass 4: “abab”, no FNR found, hence ‘#’
;; Pass 5: “ababc” the FNR character is ‘c’

;; Example 2
;; Input: $S = ‘xyzzyx’
;; Output: ‘xyzyx#’
;; Pass 1: “x”, the FNR character is “x”
;; Pass 2: “xy”, the FNR character is “y”
;; Pass 3: “xyz”, the FNR character is “z”
;; Pass 4: “xyzz”, the FNR character is “y”
;; Pass 5: “xyzzy”, the FNR character is “x”
;; Pass 6: “xyzzyx”, no FNR found, hence ‘#’
;; ----------------------------------------------------------------
