#lang racket/base

(require racket/file racket/list)

(define (copy-directory-tree source target)
  (let* ([source (string->path source)]
         [target (string->path target)]
         [source-component-length (length (explode-path source))]
         [targets
         (fold-files
          (lambda (path type paths)
            (if (eq? type 'dir)
                (cons (apply build-path target (drop (explode-path path) source-component-length)) paths)
                paths))
          '()
          source)])
    (for-each make-directory* targets)))

(copy-directory-tree "a/b/c" "x/y")
