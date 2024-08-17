#lang typed/racket/base
(require racket/string)

(: sort-string-to-char (-> String Char String))
(define (sort-string-to-char str c)
  (let ([char-list (string->list str)])
    (let loop ([prefx : (Listof Char) '()]
               [suffix : (Listof Char) char-list])
      (cond
        [(null? suffix) str]
        [(eq? (car suffix) c)
         (list->string (append (sort (cons (car suffix) prefx) char<?) (cdr suffix)))]
        [else (loop (cons (car suffix) prefx) (cdr suffix))]))))

(let* ([inputs '(
                 ("challenge" #\e)
                 ("programming" #\a)
                 ("champion" #\b)
                 ("abc1abc23a1s2d3f4" #\4)
                 ("and2 Raku3 cou4sins5 Perl are4" #\o))]
       [processed
        :
        (Listof String)
        (map (lambda ([x : (List String Char)]) (apply sort-string-to-char x)) inputs)])
  (map (lambda (p) (printf "   ~a\n" p)) inputs)
  (map (lambda (p) (printf " => ~a\n" p)) processed)
  #t)
