;; tested with:
;; echo "[a b c][d e f][g h i] | sbcl --script ch-2.lsp

(defun get-command-line ()
  (or
   #+CLISP *args*
   #+SBCL *posix-argv*
   #+LISPWORKS system:*line-arguments-list*
   #+CMU extensions:*command-line-words*
   nil))

(defparameter *cmdline* (get-command-line))
(defparameter *rows-list* '())
(defvar row '())
(defvar wrd nil)

;; read from stdin
(loop for line = (read-line *standard-input* nil)
      while line
      do(loop for ch in (coerce line 'list)
              do(if (char= ch #\[)
                    Nil ;; ignore
                  (if (or (char= ch #\]) (char= ch #\Newline))
                      (progn
                        (when (not (null wrd))
                          (let ((word-str (coerce wrd 'string)))
                            (if (null row)
                                (setq row (list word-str))
                              (nconc row (list word-str))))
                          (setq wrd '()))
                        (when (not (null row))
                          (if (null *rows-list*)
                              (setq *rows-list* (list row))
                            (nconc *rows-list* (list row)))
                          (setq row '())))
                    (if (char= ch #\Space)
                        ;; add a word to row
                        (when (not (null wrd))
                          (let ((word-str (coerce wrd 'string)))
                            (if (null row)
                                (setq row (list word-str))
                              (nconc row (list word-str))))
                          (setq wrd '()))
                      ;; else: add a char to word
                      (progn
                        (if (null wrd)
                            (setq wrd (list ch))
                          (nconc wrd (list ch)))))))))

(defparameter *num-rows* (length *rows-list*))
(defparameter *num-cols* (length (first *rows-list*)))

;; convert it into 2 dimensional array
(defvar *matrix* (make-array (list *num-rows* *num-cols*)
                             :initial-contents *rows-list*))

;; confirm input
(format t "given matrix:~%")
(dotimes (r *num-rows*)
  (setq row (loop for c from 0 below *num-cols*
                  collect (aref *matrix* r c)))
  (format t "[~{~a~^ ~}]~%" row))

;; ( solution ... )
;; this solution is only for reading
;; so I haven't check for any side effect
(defun get-spiral-array (mat) ;; take 2 dimensional array
  (let* ((num-rows (array-dimension mat 0))
         (num-cols (array-dimension mat 1))
         (sarray '())) ;; result
    (loop for o from 0
          for row-end = (1- (+ o num-rows))
          for col-end = (1- (+ o num-cols))
          do (progn
               ;; north
               (let ((north-side (loop for c from o upto col-end
                                     collect (aref mat o c))))
                 (if (null sarray)
                     (setq sarray north-side)
                   (nconc sarray north-side)))
               ;; east
               (let ((east-side (loop for r from (1+ o) upto row-end
                                       collect (aref mat r col-end))))
                 (when (not (null east-side))
                   (nconc sarray east-side)
                   ;; south
                   (let ((south-side
                          (loop for c from (1- col-end) downto o
                                collect (aref mat row-end c))))
                     (when (not (null south-side))
                       (nconc sarray south-side)
                       ;; west
                       (let ((west-side
                              (loop for r from (1- row-end) above o
                                              collect (aref mat r o))))
                         (when (not (null west-side))
                           (nconc sarray west-side))))))))
          ;; go inner
          do (progn (setq num-rows (- num-rows 2)
                          num-cols (- num-cols 2)))
          while (and (< 0 num-rows) (< 0 num-cols)))

    sarray)) ;; return

(format t "[~{~a~^ ~}]~%" (get-spiral-array *matrix*))
