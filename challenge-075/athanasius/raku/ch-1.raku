use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 075
=========================

Task #1
-------
*Coins Sum*

Submitted by: Mohammad S Anwar

You are given a set of coins _@C_, assuming you have infinite amount of each
coin in the set.

Write a script to find how many ways you make sum _$S_ using the coins from the
set _@C_.

Example:

Input:
    @C = (1, 2, 4)
    $S = 6

Output: 6
There are 6 possible ways to make sum 6.
a) (1, 1, 1, 1, 1, 1)
b) (1, 1, 1, 1, 2)
c) (1, 1, 2, 2)
d) (1, 1, 4)
e) (2, 2, 2)
f) (2, 4)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use Memoize;

subset Natural of UInt where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 075, Task #1: Coins Sum (Raku)\n".put;
}

##==============================================================================
sub MAIN
(
    Natural:D :$S,                            #= Target coin sum
    *@C where { @C.elems > 0        &&        #= Non-empty set of coin
                @C.all ~~ Natural:D &&        #=   denominations (Naturals <= S)
                @C.all <= $S }
)
##==============================================================================
{
    # Ensure that @C is a *set* by removing any duplicate coin values; also sort
    # the values

    my Nil %C = @C.map: { $_ => Nil };

    @C = %C.keys.sort( { .Int } ).map: { .UInt };

    # For non-trivial cases, memoization vastly decreases computation time

    memoize(&count-coin-combinations);

    # Reversing the coin array -- so that the coins are processed in decreasing
    # order, largest coins first, smallest coins last -- significantly reduces
    # the total number of recursive calls to count_coin_combinations()

    my UInt $total = count-coin-combinations($S, [ @C.reverse ]);

    "There %s %s possible way%s to make the sum %s from the coin%s %s\n".printf:
        $total   == 1 ?? 'is' !! 'are',
        add-commas($total),
        $total   == 1 ?? ''   !! 's',
        add-commas($S),
        @C.elems == 1 ?? ''   !! 's',
        @C.join: ', ';
}

#-------------------------------------------------------------------------------
sub count-coin-combinations
(
    Natural:D          $target,
    Array:D[Natural:D] $coins,
--> UInt:D
)
#-------------------------------------------------------------------------------
{
    my UInt $sum = 0;

    my Natural $coin = $coins.shift;

    if $coins.elems > 0             # There are more coins to process
    {
        for 0 .. floor($target / $coin) -> UInt $i
        {
            my UInt $new-target = $target - ($i * $coin);

            if $new-target == 0     # Base case 1: target already reached
            {
                ++$sum;
            }
            else                    # Recursive case
            {
                # Note: $coins is an Array object, and therefore a reference; to
                # pass it by value -- as required here -- it is necessary to
                # make a copy (clone); otherwise, the effect of shift() above
                # will propagate to recursive calls higher (i.e., earlier) in
                # the call hierarchy, leaving $coins in an incorrect state when
                # those calls are eventually made.

                $sum += count-coin-combinations($new-target, $coins.clone);
            }
        }
    }
    else                            # Base case 2: no more coins
    {
        $sum = 1 if $target % $coin == 0;
    }

    return $sum;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

#-------------------------------------------------------------------------------
sub add-commas(UInt:D $number --> Str:D)
#-------------------------------------------------------------------------------
{
    # From https://rosettacode.org/wiki/Commatizing_numbers#Raku

    return $number.subst: :1st,
                          / <[ 1 .. 9 ]> <[ 0 .. 9 ]>* /,
                          *.flip.comb( /<{ '. ** 1..3' }>/ ).join( ',' ).flip;
}

################################################################################
