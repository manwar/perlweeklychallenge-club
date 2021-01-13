use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 090
=========================

Task #2
-------
*Ethiopian Multiplication*

Submitted by: Mohammad S Anwar

You are given two positive numbers $A and $B.

Write a script to demonstrate [https://threesixty360.wordpress.com/2009/06/09/
ethiopian-multiplication/|Ethiopian Multiplication] using the given numbers.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 090, Task #2: Ethiopian Multiplication (Raku)\n".put;
}

subset Pos of Int where * > 0;

#==============================================================================
sub MAIN
(
    Pos:D $A,             #= A positive integer (the multiplier)
    Pos:D $B              #= A positive integer (the multiplicand)
)
#==============================================================================
{
    my UInt $lhs     =  $A;
    my Pos  $rhs     =  $B;
    my Pos  $l-width =  $lhs.chars;
    my Pos  $r-width = ($rhs * (2 ** floor(log2 $lhs))).chars;
    my Pos  @terms;

    while $lhs >= 1
    {
        my Str $action = 'ignore';

        if $lhs % 2 == 1
        {
            $action = 'add';
            @terms.push: $rhs;
        }

        "%*d & %*d --> %s\n".printf: $l-width, $lhs, $r-width, $rhs, $action;

        $lhs  = floor($lhs / 2);
        $rhs *= 2;
    }

    my UInt $sum = @terms.sum;

    "\n%d * %d = %s\n".printf: $A, $B, @terms.join: ' + ';
    "%s = %d\n"\      .printf: ' ' x ($l-width + 3 + $B.chars), $sum;

    my Pos $product = $A * $B;

    $sum == $product or die "ERROR: Product is $sum, should be $product\n";
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
