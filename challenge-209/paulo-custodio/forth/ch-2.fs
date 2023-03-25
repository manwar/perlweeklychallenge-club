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
            COMPARE 0= IF       \ remove next entry
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
    acc acc.emails @ emails_delete
    acc FREE THROW
;

: acc.emails_push { addr len acc -- }
    addr len acc acc.emails @ emails_push
    acc acc.emails !
;

: acc_type { acc -- }
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
    addr-name len acc_new
    accs  accs accs_size  accs[] !
    1 accs +!
    accs
;

: accs_type { accs -- }
    accs accs_size 0 ?DO
        accs I accs[] @ acc_type
    LOOP
;

: collect_args ( -- accs )
    accs_new { accs }
    BEGIN NEXT-ARG DUP 0> WHILE
        accs accs_push TO accs      \ read name
        BEGIN NEXT-ARG 2DUP S" ," COMPARE 0<> >R DUP 0<> R> AND WHILE
            \ while not empty and not comma
            accs  accs accs_size 1- accs[] @ acc.emails_push
        REPEAT
        2DROP
    REPEAT
    2DROP
    accs
;

: accs_find_common_email { accs -- a b t|f )
    0 0 FALSE { a b found }
    BEGIN a  accs accs_size 1- < WHILE
        accs a accs[] @ acc.emails @ { emails }
        emails emails_size 0 ?DO
            emails I emails[] 2@ { email_addr email_len }
            a 1+ TO b
            BEGIN b   accs accs_size < WHILE
                accs b accs[] @ acc.emails @ { emails2 }
                emails2 emails_size 0 ?DO
                    emails2 I emails[] 2@ { email2_addr email2_len }
                    email_addr email_len email2_addr email2_len
                    COMPARE 0= IF
                        a b TRUE TRUE to found LEAVE
                    THEN
                LOOP
                found IF leave THEN
                b 1+ TO b
            REPEAT
        LOOP
        found IF EXIT THEN
        a 1+ TO a
    REPEAT
    FALSE
;

: accs_merge { accs -- }
    BEGIN accs accs_find_common_email WHILE
        { a b }
        accs a accs[] @ acc.emails @ { a_emails }
        accs b accs[] @ acc.emails @ { b_emails }
        a_emails b_emails emails_merge { new_emails }
        new_emails accs a accs[] @  acc.emails  !
        accs b accs[] @ acc_delete
        accs b 1+ accs[]  accs b accs[]  accs accs_size b - 1+ CELLS MOVE
        -1 accs +!
    REPEAT
;

collect_args VALUE accs
accs accs_merge
accs accs_type
BYE
