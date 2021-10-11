use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 133
=========================

TASK #1
-------
*Integer Square Root*

Submitted by: Mohammad S Anwar

You are given a positive integer $N.

Write a script to calculate the integer square root of the given number.

Please avoid using built-in function. Find out more about it
[ https://en.wikipedia.org/wiki/Integer_square_root |here].

Examples

 Input: $N = 10
 Output: 3

 Input: $N = 27
 Output: 5

 Input: $N = 85
 Output: 9

 Input: $N = 101
 Output: 10

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------
The solution is found using both Newton's method (aka Heron's method) and the
digit-by-digit algorithm (recursive version) described in the Wikipedia article
cited in the Task Description.

=end comment
#==============================================================================

subset Positive of Int where * > 0;

my Real constant $DBL-LOG2 = 1.386_294_361_119_890_618_834_464_242_916_4;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 133, Task #1: Integer Square Root (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Positive:D $N                    #= A positive integer
)
#==============================================================================
{
    "Input:  \$N = $N".put;
    "Output: %d (Newton's method)\n"\        .printf: int-sqrt-newton( $N );
    "        %d (digit-by-digit algorithm)\n".printf: int-sqrt-digit\( $N );
}

#------------------------------------------------------------------------------
sub int-sqrt-newton( Positive:D $n --> Positive:D )
#------------------------------------------------------------------------------
{
    # x0 = 2^(⎣log2(n) / 2⎦ + 1) gives a good starting value for x0 (see
    # https://en.wikipedia.org/wiki/Integer_square_root#Numerical_example); but
    # x0 = ($n / 2) + 1 is an acceptable (and simpler) alternative :-)

    my Rat $x0 = (2 ** (floor( $n.log / $DBL-LOG2 ) + 1)).Rat;
    my Rat $x1 = ($x0 + ($n / $x0)) / 2;

    while $x1 < $x0
    {
        $x0 =   $x1;
        $x1 = (($x0 + ($n / $x0)) / 2).Rat;
    }

    return $x0.Int;
}

#------------------------------------------------------------------------------
sub int-sqrt-digit( UInt:D $n --> UInt:D )                 # Recursive function
#------------------------------------------------------------------------------
{
    return $n if $n < 2;

    my Positive $cand = (int-sqrt-digit( floor( $n / 4 ) ) * 2) + 1;

    return ($cand * $cand > $n) ?? $cand - 1 !! $cand;
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
