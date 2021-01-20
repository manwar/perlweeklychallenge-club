#! /usr/bin/env gforth

\ Challenge 096
\
\ TASK #2 > Edit Distance
\ Submitted by: Mohammad S Anwar
\ You are given two strings $S1 and $S2.
\ 
\ Write a script to find out the minimum operations required to convert $S1
\ into $S2. The operations can be insert, remove or replace a character. Please
\ check out Wikipedia page for more information.
\ 
\ Example 1:
\ Input: $S1 = "kitten"; $S2 = "sitting"
\ Output: 3
\ 
\ Operation 1: replace 'k' with 's'
\ Operation 2: replace 'e' with 'i'
\ Operation 3: insert 'g' at the end
\ Example 2:
\ Input: $S1 = "sunday"; $S2 = "monday"
\ Output: 2
\ 
\ Operation 1: replace 's' with 'm'
\ Operation 2: replace 'u' with 'o'
\
\ NOTE: the  Wagner-Fischer Distance algorithm builds a table of distances 
\		from which the operations can be deduced


\ collect arguments - strings a and b
NEXT-ARG CONSTANT len_a CONSTANT a
NEXT-ARG CONSTANT len_b CONSTANT b

\ get string char by index (1..N)
: a[]@ 		( index -- char )
	a + 1- C@ ;

: b[]@ 		( index -- char )
	b + 1- C@ ;

\ build array len_a+1 rows, len_b+1 cols
CREATE d
len_a 1+ len_b 1+ * CELLS ALLOT

\ index array
: d[] 		( i j -- addr )
	SWAP len_b 1+ * + CELLS 
	d + ;

\ init array to zeros
: clear_d	( -- )
	len_a 1+ 0 ?DO
		len_b 1+ 0 ?DO
			0 J I d[] !
		LOOP
	LOOP ;

\ init source column
: init_source	( -- )
	len_a 1+ 1 ?DO
		i  i 0 d[]  !
	LOOP ;

\ init target row
: init_target 	( -- )
	len_b 1+ 1 ?DO
		i  0 i d[]  !
	LOOP ;

\ flood-fill table
: flood_fill	( -- )
	len_b 1+ 1 ?DO
		len_a 1+ 1 ?DO
			i 1- j d[] @ 1+			\ deletion
			i j 1- d[] @ 1+			\ insertion
			i 1- j 1- d[] @ 		\ substitution
				i a[]@ j b[]@ <> IF 1+ THEN
			MIN MIN
			i j d[] !
		LOOP
	LOOP ;

\ output number without space
: .num				( n -- )
	0 U.R ;

\ output step
0 VALUE step
: show_operation	( -- )
	step 1+ TO step
	." Operation " step .num ." : " ;

\ traverse minimum path
: traverse_path	( -- )
	0 0 { i j }						\ starting point
	BEGIN i len_a < j len_b < OR WHILE
		0 { min_dir } len_a len_b + { min_delta }
		0 { dir } 0 { delta }
		
		\ search shortest path in priority SE (D), E, S
		i len_a < j len_b < AND IF
			'D' TO dir
			i 1+ j 1+ d[] @  i j d[] @  -  TO delta
			delta min_delta < IF
				dir TO min_dir
				delta TO min_delta
			THEN
		THEN
		
		j len_b < IF
			'E' TO dir
			i j 1+ d[] @  i j d[] @  -  TO delta
			delta min_delta < IF
				dir TO min_dir
				delta TO min_delta
			THEN
		THEN
		
		i len_a < IF
			'S' TO dir
			i 1+ j d[] @  i j d[] @  -  TO delta
			delta min_delta < IF
				dir TO min_dir
				delta TO min_delta
			THEN
		THEN
		
		\ apply shortest path and show steps
		min_dir 'D' = IF
			i 1+ TO i
			j 1+ TO j
			i a[]@ j b[]@ <> IF
				show_operation ." replace '" i a[]@ EMIT ." ' with '" j b[]@ EMIT ." '" CR
			THEN
		ELSE min_dir 'E' = IF
			j 1+ TO j
			show_operation ." insert '" j b[]@ EMIT ." ' at "
			j len_b = IF ." end" ELSE ." position " j .num THEN CR
		ELSE min_dir 'S' = IF
			i 1+ TO i
			show_operation ." delete '" i a[]@ EMIT ." ' at "
			j len_b = IF ." end" ELSE ." position " i .num THEN CR
		THEN THEN THEN
	REPEAT ;

: wag_fis_dist	( -- )
	clear_d init_source init_target flood_fill 
	len_a len_b d[] @ . CR			\ show distance
	traverse_path ;

wag_fis_dist
BYE
