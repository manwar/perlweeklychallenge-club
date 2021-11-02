;;;
;;; See ../README.md
;;;

;;;
;;; Run as: guile --no-auto-compile ch-1.scm
;;;

(use-modules (ice-9 format))

(define start-years       (list 1600 2000))
(define long-year-offsets (list
    004  009  015  020  026 032  037  043  048  054 060  065  071  076  082
    088  093  099                105  111  116  122 128  133  139  144  150
    156  161  167  172  178 184  189  195                201  207  212  218
    224  229  235  240  246 252  257  263  268  274 280  285  291  296  
              303  308  314 320  325  331  336  342 348  353  359  364  370
    376  381  387  392  398
))

(define (check-year start-year offset)
    (define year (+ start-year offset))
    (if (and (<= 1900 year) (<= year 2100))
        (format #t "~d~%" year)))


(for-each
    (lambda (start-year)
            (for-each
                (lambda (offset)
                        (check-year start-year offset))
                long-year-offsets))
    start-years)
