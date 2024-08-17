#lang typed/racket
(require math/array)
(require pfds/queue/bankers)

(: key->idx (-> String (Vectorof Integer)))
(define (key->idx k)
  (let* ([cr (string->list k)]
         [col : Integer (- (char->integer (car cr)) (char->integer #\a))]
         [row : Integer (- (char->integer (car (cdr cr))) (char->integer #\1))])
    (vector col row)))

(define knight-moves '((2  1) (1 2) (-2 1) (1 -2) (2 -1) (-1 2) (-2 -1) (-1 -2)))

(: get-moves (-> (Vectorof Integer) (Listof (Vectorof Integer))))
(define (get-moves idx)
  (let loop ([knight-moves : (Listof (Listof Integer)) knight-moves]
             [next-moves : (Listof (Vectorof Integer)) '()])
    (if (null? knight-moves)
        next-moves
        (let* ([move : (Listof Integer) (car knight-moves)]
               [k-next (vector (+ (vector-ref idx 0) (car move))
                               (+ (vector-ref idx 1) (car (cdr move))))])
          (if (and (>= (vector-ref k-next 0) 0)
                   (>= (vector-ref k-next 1) 0)
                   (< (vector-ref k-next 0) 8)
                   (< (vector-ref k-next 1) 8))
              (loop (cdr knight-moves) (cons k-next next-moves))
              (loop (cdr knight-moves) next-moves))))))

(: knight-path (-> String String Integer))
(define (knight-path start-key end-key)
  (let ([board (array->mutable-array (make-array #(8 8) -1))]
        [end-idx (key->idx end-key)])
    (array-set! board (key->idx start-key) 0)
    (let loop ([idx-queue (queue (key->idx start-key))])
      (if (empty? idx-queue) -1
          (let ([current (head idx-queue)])
            (if (equal? current end-idx)
                (array-ref board current)
                (let move-loop ([moves (get-moves current)]
                                [idx-queue idx-queue])
                  (if (null? moves)
                      (loop (tail idx-queue))
                      (let ([next-move (car moves)])
                        (if (eq? (array-ref board next-move) -1)
                            (begin
                              (array-set! board next-move (add1 (array-ref board current)))
                              (move-loop (cdr moves) (enqueue next-move idx-queue)))
                            (move-loop (cdr moves) idx-queue)))))))))))

(let loop ([inputs '(("a1" "f1") ("g2" "a8") ("g2" "h2") ("a1" "h8"))])
  (if (null? inputs)
      #t
      (begin
        (printf "~a => ~a~n" (car inputs) (apply knight-path (car inputs)))
        (loop (cdr inputs)))))
  
  