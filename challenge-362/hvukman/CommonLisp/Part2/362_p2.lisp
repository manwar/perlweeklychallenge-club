(ql:quickload "fiveam")
(use-package :fiveam)

(defun spellbound (x)
    (sort (copy-list x)
            (lambda (a b)
                    (string< (format nil "~R" a) (format nil "~R" b))
                    )
            )
    )


(test 362_p2test
    (is (equal '(8 9 7 6 10) (spellbound '(6 7 8 9 10))))
    (is (equal '(-3 99 1000 0) (spellbound  '(-3 0 1000 99))))
    (is (equal '(-3 99 1000 0) (spellbound  '(-3 0 1000 99))))
    (is (equal '(5 4 1 3 2) (spellbound  '(1 2 3 4 5))))
    (is (equal '(-4 -1 -3 -2 0) (spellbound  '(0 -1 -2 -3 -4))))
    (is (equal '(100 101 102) (spellbound  '(100 101 102))))
    )

(run! '362_p2test)

