#lang typed/racket/base
(require racket/string)

(struct word-idx ([token : String] [word : String] [idx : Integer]))

(: build-word-idx (-> String String (U String Number) word-idx))
(define (build-word-idx token word idx)
  (if (string? idx)
      (word-idx token word (assert (string->number idx) exact-integer?))
      (word-idx token word (assert idx exact-integer?))))

(define (good-match? (l : (U (Listof Any) False)))
  (and l (andmap string? l) (eq? (length l) 3)))

(: split-word-idx (-> String (U word-idx False)))
(define (split-word-idx token)
  (let ([pattern #px"^(\\w+?)(\\d+)$"])
    (let ([capture (regexp-match pattern token)])
      (if (good-match? capture)
          (apply build-word-idx (cast capture (List String String String)))
          #f))))

(: unshuffle-string (-> String String))
(define (unshuffle-string s)
  (let* ([splitted (string-split s)]
         [index-list (sort (filter word-idx? (map split-word-idx splitted))
                           (lambda ([x : word-idx] [y : word-idx])
                             (> (word-idx-idx x) (word-idx-idx y))))])
    (if (null? index-list)
        ""
        (let loop ([input-list index-list]
                   [out-list : (Listof String) '()]
                   [current-idx (word-idx-idx (car index-list))])
          (if (null? input-list)
              (string-join out-list)
              (let ([top-item (car input-list)])
                (cond
                  [(> current-idx (word-idx-idx top-item))
                   (loop input-list (cons "REDACTED" out-list) (sub1 current-idx))]
                  [else
                   (loop (cdr input-list)
                         (cons (word-idx-word top-item) out-list)
                         (sub1 current-idx))])))))))

(let* ([inputs '("and2 Raku3 cousins5 Perl1 are4"
                 "guest6 Python1 most4 the3 popular5 is2 language7"
                 "Challenge3 The1 Weekly2"
                 "abc1 abc 23 a1s2d3f4")]
       [processed (map unshuffle-string inputs)])
  (map (lambda (p) (printf "~a\n" p))
       inputs)
  (map (lambda (p) (printf " => ~a\n" p))
       processed)
  #t)
