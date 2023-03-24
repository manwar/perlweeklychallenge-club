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

\ mails list: word with length, dwords with each string pointer and length
: emails_new ( -- lst )
	CELL ALLOCATE THROW 0 OVER !
;

: emails_delete ( lst -- )
	FREE THROW
;

: emails_size ( lst -- size )
	@
;

: emails[] ( lst idx -- addr )
	SWAP CELL + SWAP CELLS 2* + 
;

: emails_resize ( lst size -- lst )
	2* CELLS CELL + RESIZE THROW
;

: emails_push { addr len lst -- lst }
	lst lst emails_size 1+ emails_resize TO lst 
	addr len  lst  lst emails_size  emails[]  2!
	1 lst +!
	lst
;

: emails_type { lst -- }
	lst emails_size  0 ?DO
		lst I emails[] 2@ TYPE SPACE
	LOOP
;

: emails_sort { lst -- }
	lst emails_size 1 > IF
		lst emails_size 1- 0 ?DO
			lst emails_size I 1+ ?DO
				lst J emails[] 2@
				lst I emails[] 2@
				2OVER 2OVER
				COMPARE 0> IF 
					lst J emails[] 2!
					lst I emails[] 2!
				ELSE
					2DROP 2DROP
				THEN
			LOOP
		LOOP
	THEN
;

: emails_uniq { lst -- }
	lst emails_size 1 > IF
		lst emails_sort
		0 { i }
		BEGIN i  lst emails_size 1- < WHILE
			lst i emails[] 2@
			lst i 1+ emails[] 2@
			COMPARE 0= IF		\ remove next entry
				lst i 1+ emails[]  
				lst i emails[]  
				lst emails_size i - 1- CELLS 2*
				MOVE
				-1 lst +!
			ELSE
				i 1+ TO i
			THEN
		REPEAT
	THEN
;

: emails_merge { lst1 lst2 -- lst1 }
	lst2 emails_size 0 ?DO
		lst2 I emails[] 2@
		lst1 emails_push TO lst1
	LOOP
	lst1 emails_uniq
	lst1
;

\ account: DCELL with name, CELL with emails
: acc.name ( acc -- addr ) ;
: acc.emails ( acc -- addr ) 2 CELLS + ;
: acc.emails[] ( acc idx -- addr ) acc.emails emails[] ;

: acc_new { name-addr len -- acc }
	3 CELLS ALLOCATE THROW { acc }
	name-addr len acc acc.name 2!
	emails_new acc acc.emails !
	acc
;

: acc_delete { acc -- }
	acc acc.emails emails_delete
	acc FREE THROW
;

: acc.emails_push { addr len acc -- }
	addr len acc acc.emails @ emails_push 
	acc acc.emails !
;

: acc.type { acc -- }
	acc acc.name 2@ TYPE SPACE
	acc acc.emails @ emails_type CR
;

: acc_merge { acc acc2 -- }
	acc acc.emails @ 
	acc2 acc.emails @ 
	emails_merge
	acc acc.emails !
;

\ accounts: CELL with count, CELLS with pointers to accounts
: accs_new ( -- accs )
	CELL ALLOCATE THROW
	0 OVER !
;

: accs_size ( accs -- size )
	@
;

: accs[] ( accs idx -- addr ) 
	SWAP CELL + SWAP CELLS + 
;

: accs_resize ( accs size -- accs )
	1+ CELLS RESIZE THROW
;

: accs_push { addr-name len accs -- accs }
	accs accs accs_size 1+ accs_resize TO accs 
	addr-name len acc_new  accs accs_size accs[] !
	1 accs +!
	accs
;

: accs_type { accs -- }
	accs accs_size 0 ?DO
		accs I accs[] @ acc.name 2@ TYPE SPACE
	LOOP
;


accs_new VALUE accs
S" A" accs accs_push TO accs
accs acc.type
~~ BYE

next-arg acc acc.emails_push
next-arg acc acc.emails_push
next-arg acc acc.emails_push
next-arg acc acc.emails_push
next-arg acc acc.emails_push

acc acc.type

S" B" acc_new VALUE acc2
S" 123" acc2 acc.emails_push
S" 456" acc2 acc.emails_push
S" 789" acc2 acc.emails_push
acc2 acc.type

acc acc2 acc_merge
acc acc.type

