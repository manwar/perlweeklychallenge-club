;; tested with:
;; sbcl --script ch-1.lsp 6 1 2 4 # first one: sum; rest: coins
;; ( sollution ... )
(defun combi-coin-sum (coin-sum coin-list)
  (if (null coin-list) nil
    ;; else
    (let*
        ((sorted-coin-list (sort coin-list #'<))
         (first-coin       (car sorted-coin-list))
         (max-noc          (floor coin-sum first-coin))
         (other-coins      (cdr sorted-coin-list))
         (all-combi))
      (loop for noc from max-noc downto 0
            do
            (let* ((small-change (- coin-sum (* first-coin noc))))
              (if (= small-change 0)
                  (let ((all-first-coins
                         (make-list noc :initial-element first-coin)))
                    (if (null all-combi) (setq all-combi (list all-first-coins))
                      (nconc all-combi (list all-first-coins))))
                ;; else
                (let ((sub-combis (combi-coin-sum small-change other-coins)))
                  (if (null sub-combis) nil
                    ;; else
                    (let ((head-combi
                           (make-list noc :initial-element first-coin)))
                      (map 'list
                           #'(lambda (a-sub-combi)
                               (let ((new-combi
                                      (append head-combi a-sub-combi)))
                                 (if (null all-combi)
                                     (setq all-combi (list new-combi))
                                   (nconc all-combi (list new-combi)))))
                           sub-combis)))))))  ;; if sub-combis is nil,
      (remove-if #'null all-combi))))        ;;    map will return nil

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
  (format t "Usage: sbcl --script ch-1.lsp <sum> <a coin list separated by space>"
          (first *cmdline*)))

(when (< (length *cmdline*) 3) (print-usage) (quit))

(defparameter *coin-sum* (parse-integer (second *cmdline*)))
(defparameter *coin-lst* (map 'list #'parse-integer (cddr *cmdline*)))
(format t "Input:~%@C = ( ~{~d~^, ~} )~%" *coin-lst*)
(format t "$S = ~d~%" *coin-sum*)

(let ((total-combi (combi-coin-sum *coin-sum* *coin-lst*)))
  (format t "Output: ~d~%~%" (length total-combi))
  (format t "possible ways are:~%")
  (map nil
       #'(lambda (combi)
           (progn
             (format t "( ~{~d~^, ~} )~%" combi))) total-combi))
