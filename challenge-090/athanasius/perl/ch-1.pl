#!perl

###############################################################################
=comment

Perl Weekly Challenge 090
=========================

Task #1
-------
*DNA Sequence*

Submitted by: Mohammad S Anwar

DNA is a long, chainlike molecule which has two strands twisted into a double
helix. The two strands are made up of simpler molecules called nucleotides.
Each nucleotide is composed of one of the four nitrogen-containing nucleobases
cytosine (C), guanine (G), adenine (A) and thymine (T).

You are given DNA sequence, 
GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG.

Write a script to print nucleobase count in the given DNA sequence. Also print
the complementary sequence where Thymine (T) on one strand is always facing an
adenine (A) and vice versa; guanine (G) is always facing a cytosine (C) and
vice versa.

To get the complementary sequence use the following mapping:

 T => A
 A => T
 G => C
 C => G

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;

const my $DNA_SEQ =>
         'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG';

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 090, Task #1: DNA Sequence (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    $DNA_SEQ =~ / ( [^CGAT] ) /x
        and die qq[ERROR: Invalid nucleotide "$1" found in DNA sequence\n];

    printf "DNA sequence:\n    %s\n\n",            $DNA_SEQ;
    printf "Nucleobase count:\n    %d\n\n", length $DNA_SEQ;
    printf "Complementary sequence:\n    %s\n",    $DNA_SEQ =~ tr/TAGC/ATCG/r;
}

###############################################################################
