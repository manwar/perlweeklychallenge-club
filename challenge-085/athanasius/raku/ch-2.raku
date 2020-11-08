use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 085
=========================

Task #2
-------
*Power of Two Integers*

Submitted by: Mohammad S Anwar

You are given a positive integer $N.

Write a script to find if it can be expressed as a ^ b where a > 0 and b > 1.
Print 1 if you succeed otherwise 0.

Example 1:

 Input: 8
 Output: 1 as 8 = 2 ^ 3

Example 2:

 Input: 15
 Output: 0

Example 3:

 Input: 125
 Output: 1 as 125 = 5 ^ 3

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

my Bool constant $EXPLAIN = True;

subset Positive of Int where * > 0;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 085, Task #2: Power of Two Integers (Raku)\n".put;
}

##=============================================================================
sub MAIN
(
    Positive:D $N                   #= A positive integer
)
##=============================================================================
{
    "Input:  $N".put;

    my (UInt $base, Positive $exp) = find-power($N);

    if $base == 0
    {
        "Output: 0".put;
    }
    elsif $EXPLAIN
    {
        "Output: 1 as $N = $base ^ $exp".put;
    }
    else
    {
        "Output: 1".put;
    }
}

#------------------------------------------------------------------------------
sub find-power( Positive:D $N --> List:D[UInt:D] )
#------------------------------------------------------------------------------
{
    my UInt     $base     = 0;
    my Positive $exponent = 1;
    my Positive $root     = $N.sqrt.round;

    if $root * $root == $N
    {
        $base     = $root;
        $exponent = 2;
    }
    else
    {
        my UInt $max-exp = $N.log2.round;

        loop (my UInt $exp = 3; $exp <= $max-exp; $exp += 2)
        {
            $root = ($N ** (1 / $exp)).round;

            my UInt $n  = 1;
                    $n *= $root for 1 .. $exp;

            if $n == $N
            {
                $base     = $root;
                $exponent = $exp;
                last;
            }
        }
    }

    return [$base, $exponent];
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

###############################################################################
