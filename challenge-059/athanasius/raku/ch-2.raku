use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 059
=========================

Task #2
-------
*Bit Sum*

*Reviewed by Ryan Thompson*

*Helper Function*

For this task, you will most likely need a function f(_a_,_b_) which returns the
count of different bits of binary representation of _a_ and _b_.

For example, f(1,3) = 1, since:

Binary representation of 1 = 01

Binary representation of 3 = 11

There is only 1 different bit. Therefore the subroutine should return 1. Note
that if one number is longer than the other in binary, the most significant bits
of the smaller number are padded (i.e., they are assumed to be zeroes).

*Script Output*

You script should accept _n_ positive numbers. Your script should sum the result
of f(_a_,_b_) for every pair of numbers given:

For example, given 2, 3, 4, the output would be *6*, since f(2,3) + f(2,4) +
f(3,4) = 1 + 2 + 3 = 6

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#-------------------------------------------------------------------------------
BEGIN ''.put;
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
class X::Args is Exception
#-------------------------------------------------------------------------------
{
    has Str $.msg;

    method message( --> Str:D)
    {
        return 'ERROR: ' ~ $.msg ~ "\n" ~ $*USAGE;
    }
}

#===============================================================================
sub MAIN
(
    *@numbers where { $_.all ~~ UInt:D }  #= An even number of positive integers
)
#===============================================================================
{
    "Challenge 059, Task #2: Bit Sum (Raku)\n".put;

    die X::Args.new(msg => 'Missing arguments')       if @numbers.elems == 0;
    die X::Args.new(msg => 'Odd number of arguments') if @numbers.elems %  2;

    CATCH
    {
        when X::Args { .Str.put; }
    }

    my Str  ($prob, $soln);
    my UInt ($sum,  $terms);

    while @numbers.elems
    {
        my UInt $a = @numbers.shift;
        my UInt $b = @numbers.shift;
        my UInt $f = f($a, $b);

        $prob ~= ' + ' if $terms;
        $prob ~= "f($a,$b)";
        $soln ~= ' + ' if $terms++;
        $soln ~= $f;
        $sum  += $f;
    }

    if $terms == 1
    {
        "$prob = $sum".put;
    }
    else
    {
        "$prob = $soln = $sum".put;
    }
}

#-------------------------------------------------------------------------------
sub f( UInt:D $a, UInt:D $b --> UInt:D )
#-------------------------------------------------------------------------------
{
    return '%b'.sprintf($a +^ $b).trans('0' => '').chars;
}

################################################################################
