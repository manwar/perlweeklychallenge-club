use v6;

################################################################################
=begin comment

Perl Weekly Challenge 020
=========================

Task #2
-------
Write a script to print the smallest pair of *Amicable Numbers*. For more infor-
mation, please checkout wikipedia
[ https://en.wikipedia.org/wiki/Amicable_numbers |page].

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use Math::Prime::Util:from<Perl5> <divisor_sum>;

my Sub $divisor-sum := &Math::Prime::Util::divisor_sum;     # Alias

# Command-line defaults

my UInt constant $PAIRS   = 1;         # Find first/smallest amicable pair only
my Bool constant $PERFECT = False;     # Ignore perfect numbers

BEGIN
{
    say '';
}

sub MAIN
(
    UInt:D :$pairs   = $PAIRS,         #= the number of amicable pairs to find
    Bool:D :$perfect = $PERFECT,       #= include perfect numbers in the output?
)
{
    $pairs > 0
        or die "Value \"$pairs\" invalid for option pairs (must be greater " ~
               "than zero)\n$*USAGE";

    my UInt $pairs-found   =   0;
    my UInt $perfect-found =   0;
    my      %aliquot-sums  = ( 0 => 0 );

    for 1 .. ∞ -> UInt $n
    {
        last if $pairs-found >= $pairs;

        my UInt $aliquot-sum = $divisor-sum($n) - $n;
        %aliquot-sums{ $n }  = $aliquot-sum;            # record n's aliquot-sum

        if $aliquot-sum == $n                           # n is a perfect number
        {
            "Perfect number #%d: %d\n".printf(++$perfect-found, $n) if $perfect;
        }
        elsif %aliquot-sums{ $aliquot-sum }:exists &&   # n is the larger of an
              %aliquot-sums{ $aliquot-sum } == $n       #   amicable pair
        {
            "Amicable pair %s#%d: (%d, %d)\n".printf:
                ($perfect ?? ' ' !! ''), ++$pairs-found, $aliquot-sum, $n;
        }
    }

    CATCH
    {
        default
        {
            $*ERR.say: .message;
        }
    }
}

################################################################################
