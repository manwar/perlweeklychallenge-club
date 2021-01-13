;; tested with sbcl --script ch-1.lsp 1 3 2 -1 -2 -3 6 7 9 10
;;; (output)
;; longest consecutive sequence(s): size:3
;; (-3 -2 -1)
;; (1 2 3)

;;; Comment:
;; I thought (sort x #'<) is sorted in place of x
;; however, it didn't work properly until I did (setq x (sort x #'<))


(defun get-command-line ()
  (or
   #+CLISP *args*
   #+SBCL *posix-argv*
   #+LISPWORKS system:*line-arguments-list*
   #+CMU extensions:*command-line-words*
   nil))

(defparameter *cmdline* (get-command-line))

(defun print-usage ()
  (format t "Usage: sbcl --script ch-1.lsp <integer> ..."))

(when (< (length *cmdline*) 3) (print-usage) (quit))

(defparameter *integer-list* (map 'list #'parse-integer (rest *cmdline*)))

;; even though I tried to coerce; still sorting has problem !!!
(defvar int-list (map 'list #'(lambda (x) (coerce x 'integer)) (remove-duplicates *integer-list*)))
(setq int-list (sort int-list #'<)) ;; (setq ... is must (tested with sbcl 2.0.5))
(format t "~A~%" int-list)

(when (not (= (length *integer-list*) (length int-list)))
  (format t "*THIS IS SBCL BUG*:~%Orignal list: ~A~%List after sorting: ~A~%"
          *integer-list* int-list))

(defvar longest-size 0)
(defvar longest-seq-list '())
(defvar curr-seq '())

(defvar last-int (first int-list))


;; (solution ...)
(loop for curr-int in (append (rest int-list)
                              (list (+ (apply #'max int-list) 2)))
      ;; note: dummy added for last checking any sequence left

      do(if (= last-int (1- curr-int))
            (if (null curr-seq)
                (setq curr-seq (list last-int curr-int))
              (nconc curr-seq (list curr-int)))
          ;; else
          (let ((curr-size (length curr-seq)))
            (if (< longest-size curr-size)
                (setq longest-size curr-size
                      longest-seq-list  (list curr-seq))
              ;; else
              (when (= longest-size curr-size)
                (setq longest-seq-list
                      (append longest-seq-list (list curr-seq)))))
            (setq curr-seq '())))

      do(setq last-int curr-int))

(if (< 0 longest-size )
    (progn
      (format t "longest consecutive sequence(s): size:~A~%" longest-size)
      (map nil #'(lambda (a-list) (format t "~A~%" a-list)) longest-seq-list))
  (format t "0 as no consecutive sequence found"))

(quit)
