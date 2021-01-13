use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 066
=========================

Task #2
-------
*Power Integers*

*Submitted by:* Mohammad S Anwar

You are given an integer $N.

Write a script to check if the given number can be expressed as *m^n* where m
and n are positive integers. Otherwise print 0.

Please make sure m > 1 and n > 1.

*BONUS: If there are more than one ways to express the given number then print
all possible solutions.*

*Example 1:*

For given $N = 9, it should print 3² or 3^2.

*Example 2:*

For given $N = 45, it should print 0.

*Example 3:*

For given $N = 64, it should print all or one of 8^2 or 2^6 or 4^3.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#-------------------------------------------------------------------------------
BEGIN ''.put;
#-------------------------------------------------------------------------------

#===============================================================================
sub MAIN( Int:D $N )        #= an integer
#===============================================================================
{
    "Challenge 066, Task #2: Power Integers (Raku)\n".put;

    my Bool $done = False;

    if $N > 1
    {
        my Str @powers = find-powers($N);

        if @powers.elems
        {
            @powers.join('  ').put;
            $done = True;
        }
    }

    0.put unless $done;
}

#-------------------------------------------------------------------------------
sub find-powers( Int:D $N --> Array[Str] )
#-------------------------------------------------------------------------------
{
    my Str @powers;

    # The minimum exponent n is 2, since n > 1 (given)
    # The maximum exponent n is that for which the base m is minimum (also 2),
    #     so  2^n = N  =>  n = log⸤2⸥(N)

    my UInt $max-n = (log($N) / log(2)).floor;

    for 2 .. $max-n -> UInt $n                          # exponent
    {
        my UInt $m = (($N ** (1 / $n)) + 0.5).floor;    # base

        # From the Raku documentation for infix **:
        # "If the right-hand side is a non-negative integer and the left-hand
        #  side is an arbitrary precision type (Int, FatRat), then the calcula-
        #  tion is carried out without loss of precision."

        @powers.push: "$m^$n" if $m ** $n == $N;        # power
    }

    return @powers;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

################################################################################
