use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 106
=========================

*Decimal String*

Submitted by: Mohammad S Anwar

You are given numerator and denominator i.e. $N and $D.

Write a script to convert the fraction into decimal string. If the fractional
part is recurring then put it in parenthesis.

Example

 Input: $N = 1, $D = 3
 Output: "0.(3)"

 Input: $N = 1, $D = 2
 Output: "0.5"

 Input: $N = 5, $D = 66
 Output: "0.0(75)"

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------
The Raku Rat class (which does the Rational role) has a mathod base-repeating()
which returns, separately, the non-repeating part and the repeating part (if
any) of a given rational number.

=end comment
#==============================================================================

my UInt constant $BASE = 10;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 106, Task #2: Decimal String (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Int:D $N,                               #= Numerator (an integer)
    Int:D $D where { $D != 0 }              #= Denominator (a non-zero integer)
)
#==============================================================================
{
    "Input:  \$N = $N, \$D = $D".put;

    my Rat  $fraction       = Rat.new( $N, $D );
    my Str ($non-rep, $rep) = $fraction.base-repeating( $BASE );

    qq[Output: "%s%s"\n].printf: $non-rep, $rep ?? "($rep)" !! '';
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
