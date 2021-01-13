#! /usr/bin/env gforth

\ Challenge 001
\ 
\ Challenge #1
\ Write a script to replace the character ‘e’ with ‘E’ in the string ‘Perl Weekly Challenge’. Also print the number of times the character ‘e’ is found in the string.

CREATE message ," Perl Weekly Challenge"

: replace-e 			( cstr -- n )
	0 SWAP				( n cstr ) 		\ n = number of chars replaced )
	COUNT BOUNDS ?DO
		I C@ 'e' = IF	\ is an 'e'
			'E' i C! 	\ replace by 'E'
			1+			\ count it
		THEN
	LOOP
;

message replace-e . 
message COUNT TYPE CR
BYE
