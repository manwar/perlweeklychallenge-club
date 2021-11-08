#!/usr/bin/sbcl --script

(defun isPalindrome( n )
(let (( num ( format nil "~d" n ))
      ( reversed ))
  (setq reversed (reverse num))
  (string=  num reversed )))

(defun solution ( n )
(do
  (( p (+ 1 n ) (+ 1 p )))
  ((isPalindrome p) p )))

(format t "~d~%" (solution 1234))
