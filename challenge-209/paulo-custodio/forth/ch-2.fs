#! /usr/bin/env gforth

\ Challenge 209
\ 
\ Task 2: Merge Account
\ Submitted by: Mohammad S Anwar
\ 
\ You are given an array of accounts i.e. name with list of email addresses.
\ 
\ Write a script to merge the accounts where possible. The accounts can only
\ be merged if they have at least one email address in common.
\ 
\ Example 1:
\ 
\ Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
\                      ["B", "b1@b.com"],
\                      ["A", "a3@a.com", "a1@a.com"] ]
\                    ]
\ 
\ Output: [ ["A", "a1@a.com", "a2@a.com", "a3@a.com"],
\           ["B", "b1@b.com"] ]
\ 
\ Example 2:
\ 
\ Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
\                      ["B", "b1@b.com"],
\                      ["A", "a3@a.com"],
\                      ["B", "b2@b.com", "b1@b.com"] ]
\ 
\ Output: [ ["A", "a1@a.com", "a2@a.com"],
\           ["A", "a3@a.com"],
\           ["B", "b1@b.com", "b2@b.com"] ]

\ string list: word with length, dwords with each string pointer and length
: str_list_new ( -- lst )
	CELL ALLOCATE THROW 0 OVER !
;

: str_list_delete ( lst -- )
	FREE THROW
;

: str_list_size ( lst -- size )
	@
;

: str_list[] ( lst idx -- addr )
	SWAP CELL + SWAP CELLS 2* + 
;

: str_list_resize ( lst size -- lst )
	2* CELLS CELL + RESIZE THROW
;

: str_list_push { addr len lst -- lst }
	lst lst str_list_size 1+ str_list_resize TO lst 
	addr len  lst  lst str_list_size  str_list[]  2!
	1 lst +!
	lst
;

: str_list_type { lst -- }
	lst str_list_size  0 ?DO
		lst I str_list[] 2@ TYPE SPACE
	LOOP
;

: str_list_sort { lst -- }
	lst str_list_size 1 > IF
		lst str_list_size 1- 0 ?DO
			lst str_list_size I 1+ ?DO
				lst J str_list[] 2@
				lst I str_list[] 2@
				2OVER 2OVER
				COMPARE 0> IF 
					lst J str_list[] 2!
					lst I str_list[] 2!
				ELSE
					2DROP 2DROP
				THEN
			LOOP
		LOOP
	THEN
;

: str_list_uniq { lst -- }
	lst str_list_size 1 > IF
		lst str_list_sort
		0 { i }
		BEGIN i  lst str_list_size 1- < WHILE
			lst i str_list[] 2@
			lst i 1+ str_list[] 2@
			COMPARE 0= IF		\ remove next entry
				lst i 1+ str_list[]  
				lst i str_list[]  
				lst str_list_size i - 1- CELLS 2*
				MOVE
				-1 lst +!
			ELSE
				i 1+ TO i
			THEN
		REPEAT
	THEN
;

		
str_list_new VALUE lst
lst 64 dump
next-arg lst str_list_push TO lst
next-arg lst str_list_push TO lst
next-arg lst str_list_push TO lst
next-arg lst str_list_push TO lst
next-arg lst str_list_push TO lst
lst 64 dump
lst str_list_type CR
lst str_list_uniq
lst str_list_type CR
lst 64 dump

~~ bye
