#!/usr/local/bin/guile
!#

;;;
;;; See https://theweeklychallenge.org/blog/perl-weekly-challenge-149
;;;

;;;
;;; Run as: guile --no-auto-compile ch-2.scm < input-file
;;;

(use-modules (ice-9 rdelim))

(define A287298 '())
(define max_base 25)

(set! A287298 (append A287298 (list                          "")))
(set! A287298 (append A287298 (list                          "")))
(set! A287298 (append A287298 (list                         "1")))
(set! A287298 (append A287298 (list                         "1")))
(set! A287298 (append A287298 (list                      "3201")))
(set! A287298 (append A287298 (list                      "4301")))
(set! A287298 (append A287298 (list                    "452013")))
(set! A287298 (append A287298 (list                   "6250341")))
(set! A287298 (append A287298 (list                  "47302651")))
(set! A287298 (append A287298 (list                 "823146570")))
(set! A287298 (append A287298 (list                "9814072356")))
(set! A287298 (append A287298 (list               "A8701245369")))
(set! A287298 (append A287298 (list              "B8750A649321")))
(set! A287298 (append A287298 (list              "CBA504216873")))
(set! A287298 (append A287298 (list            "DC71B30685A924")))
(set! A287298 (append A287298 (list           "EDAC93B24658701")))
(set! A287298 (append A287298 (list          "FED5B39A42706C81")))
(set! A287298 (append A287298 (list          "GFED5A31C6B79802")))
(set! A287298 (append A287298 (list        "HGF80ADC53712EB649")))
(set! A287298 (append A287298 (list       "IHGFD3408C6E715A2B9")))
(set! A287298 (append A287298 (list      "JIHG03DAC457BFE96281")))
(set! A287298 (append A287298 (list                          "")))
(set! A287298 (append A287298 (list    "LKJIG5D14B9032FHAC867E")))
(set! A287298 (append A287298 (list   "MLKJEFG5IC1D9H8042AB376")))
(set! A287298 (append A287298 (list  "NMLKJ2BD0639GFE7C8IH5A41")))
(set! A287298 (append A287298 (list "ONMLKD8CJE2H47F6395I0B1AG")))

(define (main)
    (define line (read-line))
    (define n)
    (if (not (eof-object? line))
        (begin
            (set! n (string->number line))
            (display (cond ((> n max_base) "Too hard to calculate")
                           ((string-null? (list-ref A287298 n))
                                     "Too hard to calculate")
                           (else (list-ref A287298 n))))
            (newline)
            (main)
        )
    )
)

(main)
