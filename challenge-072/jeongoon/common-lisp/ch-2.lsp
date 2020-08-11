;; Ref:
;; http://www.gigamonkeys.com/book/files-and-file-io.html
;; http://cl-cookbook.sourceforge.net/files.html#open
;; http://www.ai.sri.com/pkarp/loop.html

(defun get-command-line ()
  (or
   #+CLISP *args*
   #+SBCL *posix-argv*
   #+LISPWORKS system:*line-arguments-list*
   #+CMU extensions:*command-line-words*
   nil))

(defparameter *cmdline* (get-command-line))

(defun print-usage ()
  (format t "Usage: sbcl --script ch-2.lsp <file-path> <from> <to>~%" (car *cmdline*)))

(when (not (= (length *cmdline*) 4)) ;; not 3
  (format t "Wrong Number of arguments got ~d: not 3~%" (length *cmdline*))
  (print-usage)
  (quit))

(defparameter *file-path* (nth 1 *cmdline*))
(defparameter *from*      (parse-integer (nth 2 *cmdline*)))
(defparameter *to*        (parse-integer (nth 3 *cmdline*)))

(when (not (probe-file *file-path*))
  (format t "Could not read the file ~a~%" *file-path*)
  (quit))

(when (not (and (numberp *from*) (numberp *to*)))
  (format t "given numbers are not in the range: from ~a, to ~a" *from* *to*)
  (quit))

(format t "[INF] File: ~a: from: ~d to: ~d~%" *file-path* *from* *to*)

(with-open-file
 (in *file-path* :if-does-not-exist nil) ;; return nil instead of error
 (loop for line = (read-line in nil)
       for cnt from 1  ;; cool auto counter

       while line do   ;; I don't know whay parenthesis is not used here.
                       ;; look like a macro for something
       (progn
         (when (and (<= *from* cnt) (<= cnt *to*))
           (format t "~a~%" line))
         (when (= cnt *to*)
           (format t "[INF] Done.~%")
           (return "[done]"))
         (setq cnt (+ 1 cnt)))))
