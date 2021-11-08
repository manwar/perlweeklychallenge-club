use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 118
=========================

TASK #1
-------
*Binary Palindrome*

Submitted by: Mohammad S Anwar

You are given a positive integer $N.

Write a script to find out if the binary representation of the given integer is
Palindrome. Print 1 if it is otherwise 0.

Example

 Input: $N = 5
 Output: 1 as binary representation of 5 is 101 which is Palindrome.

 Input: $N = 4
 Output: 0 as binary representation of 4 is 100 which is NOT Palindrome.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

1. Convert $N to binary using the Real::base method with $base = 2.

2. Determine whether the binary representation of $N is a palindrome or not by
   comparing the first digit with the last, the second digit with the second-
   last, and so on. (The middle digit, if any, is ignored.)

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 118, Task #1: Binary Palindrome (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $N                      #= A positive integer
)
#==============================================================================
{
    my UInt $n = $N + 0;           # Normalize: e.g., 010 --> 10, 0x10 --> 16

    "Input:  \$N = $n".put;

    # Make an array of the digits in the binary representation of $N

    my Str @binary = $n.base( 2 ).split: '', :skip-empty;

    # Assume the binary representation is a palindrome unless and until we find
    # a non-matched pair of binary digits (counting inwards from either end)

    my Bool $is-palindrome = True;

    for 0 .. floor( @binary.elems / 2 ) -> UInt $i
    {
        if @binary[ $i ] ne @binary[ @binary.end - $i ]
        {
            $is-palindrome = False;
            last;
        }
    }

    ("Output: %d as the binary representation of %d is %s\n" ~
     "          which is %sa palindrome\n").printf:
        $is-palindrome ??  1 !!    0,  $n,  @binary.join,
        $is-palindrome ?? '' !! 'NOT ';
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

##############################################################################
