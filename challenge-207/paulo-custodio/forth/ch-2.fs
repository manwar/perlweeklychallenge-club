\ Challenge 207
\
\ Task 2: H-Index
\ Submitted by: Mohammad S Anwar
\
\ You are given an array of integers containing citations a researcher has
\ received for each paper.
\
\ Write a script to compute the researcher’s H-Index. For more information
\ please checkout the wikipedia page.
\
\     The H-Index is the largest number h such that h articles have at least h
\     citations each. For example, if an author has five publications,
\     with 9, 7, 6, 2, and 1 citations (ordered from greatest to least),
\     then the author’s h-index is 3, because the author has three publications
\     with 3 or more citations. However, the author does not have four
\     publications with 4 or more citations.
\
\
\ Example 1
\
\ Input: @citations = (10,8,5,4,3)
\ Output: 4
\
\ Because the 4th publication has 4 citations and the 5th has only 3.
\
\ Example 2
\
\ Input: @citations = (25,8,5,3,3)
\ Output: 3
\
\ The H-Index is 3 because the fourth paper has only 3 citations.

CREATE citations 256 CELLS ALLOT
0 VALUE num_citations

: citation[] ( i -- addr )
    CELLS citations +
;

: collect_args ( -- )
    BEGIN NEXT-ARG DUP WHILE
        0 0 2SWAP >NUMBER 2DROP DROP
        num_citations citation[] !
        num_citations 1+ TO num_citations
    REPEAT
    2DROP
;

\ reverse sort array of integers
: rsort ( -- )
    num_citations 0> IF
        num_citations 1- 0 ?DO
            num_citations I 1+ ?DO
                J citation[] @
                I citation[] @
                < IF
                    J citation[] @ I citation[] @ J citation[] ! I citation[] !
                THEN
            LOOP
        LOOP
    THEN
;

\ H-index
: h_index ( -- n )
    -1
    num_citations 0 ?DO
        I citation[] @  I 1+ < IF
            DROP I LEAVE
        THEN
    LOOP
;

collect_args
rsort
h_index . CR
BYE
