use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 153
=========================

TASK #2
-------
*Factorions*

Submitted by: Mohammad S Anwar

You are given an integer, $n.

Write a script to figure out if the given integer is factorion.

    A factorion is a natural number that equals the sum of the factorials of
    its digits.

Example 1:

 Input: $n = 145
 Output: 1

     Since 1! + 4! + 5! => 1 + 24 + 120 = 145

Example 2:

 Input: $n = 125
 Output: 0

     Since 1! + 2! + 3! => 1 + 2 + 6 <> 123

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Output
------
If the constant $VERBOSE is set to True (the default), an explanation like
those given in the Examples is added to the output.

Algorithm
---------
Using a look-up for the factorials of numbers 0 to 9 [1], the factorials of the
digits of $n are summed and the result compared with $n.

Reference
---------
[1] Wikipedia article "Factorial" (https://en.wikipedia.org/wiki/Factorial)

=end comment
#==============================================================================

my Bool constant $VERBOSE   = True;
my      constant %FACTORIAL = Hash[UInt].new: 0 =>       1,
                                              1 =>       1,
                                              2 =>       2,
                                              3 =>       6,
                                              4 =>      24,
                                              5 =>     120,
                                              6 =>     720,
                                              7 =>   5_040,
                                              8 =>  40_320,
                                              9 => 362_880;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 153, Task #2: Factorions (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Int:D $n                           #= An integer
)
#==============================================================================
{
    # Remove sign and initial zeros (if any)

    my Int $sign  = $n >= 0 ?? 1 !! -1;
    my Int $n-abs = $n.subst( / ^ <[+-]> / ).Int;

    "Input:  \$n = %d\n".printf: $n-abs * $sign;

    my Str  @digits   = $n-abs.split: '', :skip-empty;
    my UInt $sum      = [+] @digits.map: { %FACTORIAL{ $_ } };
    my Bool $is-factn = $sum == $n;

    "Output: %d\n".printf: $is-factn ?? 1 !! 0;

    if $VERBOSE
    {
        if $n-abs.chars == 1
        {
            "\n    Since %s! = %d\n".printf: $n-abs, $sum;
        }
        else
        {
            "\n    Since %s! = %s = %d\n".printf: @digits.join( '! + ' ),
                @digits.map( { %FACTORIAL{ $_ } } ).join( ' + ' ), $sum;
        }
    }
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
