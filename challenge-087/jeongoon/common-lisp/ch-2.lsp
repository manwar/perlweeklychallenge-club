;; tested with:
;; echo "[000111][111111][001001][001111][001111] | sbcl --script ch-2.lsp
;; [000111]
;; [111111]
;; [001001]
;; [001111]
;; [001111]

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

;; read from stdin
(loop for line = (read-line *standard-input* nil)
      while line
      do(loop for ch in (coerce line 'list)
              do(if (or (char= ch #\1) (char= ch #\0))
                     (if (null row) (setq row (list ch)) (nconc row (list ch)))
                  (when (or (char= ch #\])
                            (and (char= ch #\newline) (not (null row))))
                    (if (null *rows-list*)
                          (setq *rows-list* (list row))
                        (nconc *rows-list* (list row)))
                    (setq row '())))))


(defparameter *num-rows* (length *rows-list*))
(defparameter *num-columns* (length (first *rows-list*)))

(defun ch-087/subsequences (lines)
  (let ((seqs '()))
    (loop for line in lines
          do(loop while (not (null line))
                  do(let ((points-so-far '()))
                      (loop for point in line
                            do(progn
                                (if (null points-so-far)
                                    (setq points-so-far (list point))
                                  (nconc points-so-far (list point)))
                                (if (null seqs)
                                    (setq seqs (list (copy-list
                                                      points-so-far)))
                                  (nconc seqs (list (copy-list
                                                     points-so-far)))))))
                  (setq line (rest line))))
    seqs))

;;;
;;; check data row by row and find lines which consist of cosecutive points
;;;
(defun find-consecuative-lines (columns) ;; a point inclusive
                                         ;; i.e. (1 1 1 0 1) -> ((0 1 2) (4))
                                         ;; and more ((0) (1) (2) (0 1) (1 2)
                                         ;; (0 1 2) (4))
  (let* ((lines '())
         (curr-points '())
         (prev (first columns)))
    (when (char= #\1 prev) (setq curr-points (list 0)))
    (loop for curr in (rest columns)
          for i from 1
          do(if (char= #\1 prev)
                (if (char= #\1 curr)
                    (if (null curr-points)
                        (setq curr-points (list (1- i) i)) ;; remember position
                      (nconc curr-points (list i)))
                  ;; current line ends here: push into lines list
                  (progn
                    (if (null lines)
                        (setq lines (list curr-points))
                      (nconc lines (list curr-points)))
                    (setq curr-points '())))
              ;; there is no line we looking at currently
              (when (char= #\1 curr) ;; but start new one
                  (setq curr-points (list i))) ;; remember position
              )
          do(setq prev curr))
    (when (not (null curr-points)) ;; add if loop not executed or ended without
                                   ;; appending last line
      (if (null lines)
          (setq lines (list curr-points))
        (nconc lines (list curr-points))))
    (ch-087/subsequences lines)))  ;; get subsequeces as well


(defvar lines-per-row)
(setq lines-per-row
      (loop for row in *rows-list*
            for ri  from 0
            collect (map 'list #'(lambda (ls) (cons ri (list ls)))
                         (find-consecuative-lines row))))

;;(format t "~A~%" lines-per-row)

(defun ch-087/intersects (cmp-list)
  ;; get intersections of all member in cmp-list
  ;; but with :key #'cdr :test #'equal
  (if (< (length cmp-list) 1)
      '() ;; empty list
    ;; else
    (let* ((inters (first cmp-list)))
      (loop for curr in (rest cmp-list)
            do(progn
                (setq inters (intersection inters curr
                                           :key #'cdr :test #'equal))
                ;;(format t "inters: ~a~%" inters)
                (when (null inters) (return))))
      (map 'list #'(lambda (x) (cadr x)) inters))))

(defvar lines-per-row-cp (copy-list lines-per-row))
(defvar found-rectangles '())

;;
;; find possible rectangles
;;
(loop for base from 0
      ;; note: checking procedure is similar to below
      ;; 1 2 3 4 ->
      ;; 1 -> 1 2 -> 1 2 3 -> 1 2 3 4
      ;; 2 -> 2 3 -> 2 3 4 ->
      ;; 3 -> 3 4 ->
      ;; 4
      while (not (null lines-per-row-cp))
      do(let ((lines-in-rows '())
              (rows-numbers '())
              (intersection-so-far '())
              (inters '()))
          (loop named adding-row
                for line-in-row in lines-per-row-cp
                for offset from 0
                do (progn
                     (if (null rows-numbers)
                         (setq rows-numbers (list (+ base offset)))
                       (nconc rows-numbers (list (+ base offset))))
                     (setq lines-in-rows (append lines-in-rows
                                                 (list line-in-row)))
                     (setq inters
                           (ch-087/intersects lines-in-rows))
                     (if (null inters)
                         (return-from adding-row) ;; no need to go further
                       (setq intersection-so-far
                             ;; making a list looks like below
                             ;; ( ( (row numbers ...) (points ...) ) ... )
                             (map
                              'list #'(lambda (x)
                                        (cons rows-numbers (list x)))
                              inters)))))

           ;; sometimes collect() is working unexpectedly
           ;; (probably thanks to lack of my knowledge -.-;)
           ;; just do(let... setq(... )) by myself
          (when (not (null intersection-so-far))
            (if (null found-rectangles)
                (setq found-rectangles (copy-list intersection-so-far))
              (nconc found-rectangles (copy-list intersection-so-far)))))
      ;; reducing list
      do (setq lines-per-row-cp (cdr lines-per-row-cp)))

;;(format t "~A~%" found-rectangles)

;;
;; find largest
;;
;; ( ((0 1) (1 2))  ;; (row from 0 to 1) (column from 1 to 2)
;;   ((1 2 3) (4 5)) ... )

(defvar largest-area 0)
(defvar largest-rectangle-list '())

(loop for rect in found-rectangles
      do (let* ((rows (car rect))
                (cols (cadr rect))
                (curr-area (* (length rows) (length cols))))
           (if (= curr-area 1)
               nil ;; ignore if it is a point
             (if  (< largest-area curr-area)
                 ;; update
                 (progn (setq largest-area curr-area)
                        (setq largest-rectangle-list (list rect)))
               (when (= largest-area curr-area)
                 ;; append
                 (if (null largest-rectangle-list)
                     (setq largest-rectangle-list (list rect))
                   (nconc largest-rectangle-list (list rect))))))))
;;
;; show the result
;;

(if (null largest-rectangle-list)
    (format t "0 as no rectangle found")
  (dolist (rect largest-rectangle-list)
    (let* ((rows (car rect))
           (cols (cadr rect)))
      (format t "largest area: ~d~%" largest-area)
      (format t "at (r:~d,c:~d)~%" (first rows) (first cols))
      (dotimes (r (length rows))
        (format t "~{~a~^ ~}~%"
                (coerce (make-array
                         (length cols) :initial-element #\1) 'list))))))
