\ Challenge 090
\ TASK #1 › DNA Sequence
\ Submitted by: Mohammad S Anwar
\ DNA is a long, chainlike molecule which has two strands twisted into a
\ double helix. The two strands are made up of simpler molecules called
\ nucleotides. Each nucleotide is composed of one of the four nitrogen-containing
\ nucleobases cytosine (C), guanine (G), adenine (A) and thymine (T).
\
\ You are given DNA sequence,
\ GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG.
\
\ Write a script to print nucleiobase count in the given DNA sequence.
\ Also print the complementary sequence where Thymine (T) on one strand
\ is always facing an adenine (A) and vice versa; guanine (G) is always
\ facing a cytosine (C) and vice versa.

\ Start the script with the DNA sequence is the command line, e.g.
\   gforth ch-1.fs GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG

\ The solution copies the input string to the PAD and then replaces
\ each character representing a nucleiobase by its complement.

: compl-one     ( c -- c )
    DUP      'T' = IF DROP 'A'
    ELSE DUP 'A' = IF DROP 'T'
    ELSE DUP 'G' = IF DROP 'C'
    ELSE DUP 'C' = IF DROP 'G'
    ELSE DROP BL
    THEN THEN THEN THEN
;

: compl-seq     ( c-addr n -- c-addr n )
    PAD C!
    PAD 1+ PAD C@ CMOVE \ copy as counted string to PAD
    PAD 1+
    PAD C@ 0 DO
        DUP C@ compl-one OVER C! 1+
    LOOP
    PAD COUNT
;

next-arg                \ collect string
DUP . CR                \ print length
compl-seq TYPE CR       \ print complemented sequence
BYE
