use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 171
=========================

TASK #1
-------
*Abundant Number*

Submitted by: Mohammad S Anwar

Write a script to generate first 20 Abundant Odd Numbers.

According to [ https://en.wikipedia.org/wiki/Abundant_number |wikipedia],


    A number n for which the sum of divisors σ(n) > 2n, or, equivalently, the
    sum of proper divisors (or aliquot sum) s(n) > n.


For example, 945 is the first Abundant Odd Number.

  Sum of divisors:
  1 + 3 + 5 + 7 + 9 + 15 + 21 + 27 + 35 + 45 + 63 + 105 + 135 + 189 + 315 = 975

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Configuration
-------------
Set $VERBOSE to True to display the proper divisors and their sum for each
abundant odd number found.

Algorithm
---------
The subroutine proper-divisors() searches the range 2 to ⌊√n⌋ for factors of n,
recording each pair of factors as found.

=end comment
#==============================================================================

my UInt constant $TARGET  = 20;
my Bool constant $VERBOSE = False;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 171, Task #1: Abundant Number (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my UInt        @abundant;
    my Array[UInt] @divisors if $VERBOSE;
    my UInt        @sums     if $VERBOSE;

    for 1, 3 ... * -> UInt $n
    {
        my UInt @divs = proper-divisors( $n );
        my UInt $sum  = [+] @divs;

        if $sum > $n
        {
            @abundant.push: $n;
            @divisors.push: @divs if $VERBOSE;
            @sums.push:     $sum  if $VERBOSE;
        }
 
        last if +@abundant >= $TARGET;
    }

    "The first $TARGET abundant odd numbers:".put;

    if $VERBOSE
    {
        for 0 .. @abundant.end -> UInt $i
        {
            "%2d. %4d: %s = %d\n".printf:  $i + 1, @abundant[ $i ],
                @divisors[ $i ].list.sort.join( '+' ), @sums[ $i ];
        }
    }
    else
    {
        "%s\n".printf: @abundant.join: ', ';
    }
}

#------------------------------------------------------------------------------
sub proper-divisors( UInt:D $n --> Array:D[UInt:D] )
#------------------------------------------------------------------------------
{
    my UInt @divisors = 1;

    unless is-prime( $n )
    {
        for 2 .. $n.sqrt.floor -> UInt $d
        {
            @divisors.push: $d, $n div $d if $n %% $d;
        }
    }

    return @divisors;
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
