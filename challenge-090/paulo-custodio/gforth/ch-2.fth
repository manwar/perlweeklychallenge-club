\ Challenge 090
\ TASK #2 › Ethiopian Multiplication
\ Submitted by: Mohammad S Anwar
\ You are given two positive numbers $a and $b.
\ 
\ Write a script to demonstrate Ethiopian Multiplication using the given numbers.

: mult 		{ a b -- a*b }		\ a, b: locals
	0							( sum )
	BEGIN
		a 1 AND IF 				\ a is even
			b +					\ sum += b
		THEN
		a 1 = IF EXIT THEN		\ exit when a=1
		a 2/ TO a
		b 2* TO b
	AGAIN
;

\ input in stack
mult . CR BYE
