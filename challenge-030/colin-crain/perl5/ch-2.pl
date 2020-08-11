#! /opt/local/bin/perl
#
#        series_triplets.pl
#
#        Task #2
#             Write a script to print all possible series of 3 numbers, where in each series
#             at least one of the number is even and sum of the three numbers is always 12.
#             For example, 3,4,5.
#
#     method: ok, first of all as written, literally, there are, trivially, an
#         infinite number of triples:
#             [ 3-n, 4, 5+n] for n subset Z, n = ( 0 --> infinity)
#         and an infinite set of variations on this basic generator where the
#         series sums to 12 and one item is even. If we allow Real numbers, which are of course numbers
#         too, things really begin to blow up. So on the face of it, this
#         challenge cannot be completed, because an infinite number of generative
#         combinations of infinite sets of triples cannot be printed.
#
#         So if we want to solve a problem that can in fact be solved, or more
#         specifically can be printed, one way out would be to include the
#         specifier 'Natural' in the question, limiting us to the set of Natural
#         numbers. Allowing Z, the integers, and with it the negative numbers, in
#         turn allows one to add +1 and -1 to a pair in any valid set of triples
#         and we have an infinite set of answers again. So it must be Naturals.
#         Thus we get "...print all possible series of 3 Natural numbers..." and
#         the challenge is once again manageable. We'll go with that, with N(0)
#         rather than N(1), that is to say the set of cardinal numbers starting at
#         0, rather than 1. Because why not, 0 is quite even, and it allows a few
#         more possibilities.
#
#         With this change, the problem is reduced to one of combinatorics, and the usual
#         related conditional questions then arise:
#             - Do we allow repeat elements?
#             - Do we count permutations of the same elements, or, does ordering matter?
#
#         The challenge requested 'series' of numbers, which is normally
#         considered the sum of a sequence, which in turn is not the same as a
#         set. So the sequence [3, 4, 5] is not the same as [5, 4, 3] and thus
#         these would be two distinct series that each sum to 12 and satisfy the
#         conditions. It's not clear whether this was the intent of the author.
#         It's also a little repetitive in the data produced, as each valid triple
#         adds all permutations of those values to the result. However basic set
#         theory only maintains the concept of inclusivity rather than ordering in
#         a set, so the set [3,3,6] is the same as the set [3,6] and the set
#         [6,6,3] and any concepts of ordering the elements is an extension of
#         this basic theory. If we consider a series a progressive sequence, with
#         a delta between values drawn from N(0), we end up allowing repetition
#         (d=0) and ascending order, so any valid triplet is only presented once.
#         This may or may not be the data requested, but is quite a bit simpler.
#
#         In the end perhaps it is best to provide all these results, while
#         acknowledging there are still additional ways to interpret the question.
#
#         As a further note, in a given set of 3 numbers [a,b,c], either ordered
#         or unordered, the only case where no number a, b or c is even, as
#         specified, is where all a, b and c are odd. It is then strightforward to
#         prove that the sum of any three odd numbers is also itself odd, because
#         the sum of two odd numbers is even, and the sum of one even and one odd
#         number is odd. The number 12 is not odd, thus the criteion "at least one
#         of the number is even" is superfluous and need not be tested.
#
#         Our final specification(s) can be, possibly:
#             - all possible sequences of 3 Natural numbers where the sum of the three numbers is 12. (91 combinations)
#        or,
#             - all possible sets of 3 Natural numbers where the sum of the three numbers is 12. (72 combinations)
#        or maybe,
#             - all possible ascending ordered sets of 3 Natural numbers where the sum of the three numbers is 12. (19 combinations)
#
#
#
#        2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN


## it's only maximally 13^3 combinations, and we can just look at them all
my ($a, $b, $c);
my $count;

## here we calculate every valid sequence, including permutations
say "sequences (allowing repetition): ";
$count = 0;
for $a ( 0..12 ) {
    for $b ( 0..12 ) {
        next if ($a + $b > 12);
        for $c ( 0..12 ) {
            next unless ($a + $b + $c == 12);
            say "[ $a, $b, $c ]";
            $count++;
        }
    }
}
say "total $count combinations\n\n";

say "-" x 12;

## here we calculate the triples without allowing repetition
say "sets (no repetition): ";
$count = 0;
for $a ( 0..12 ) {
    for $b ( 0..12 ) {
        next if ($a + $b > 12);
        next if ($a == $b);
        for $c ( 0..12 ) {
            next unless ($a + $b + $c == 12);
            next if ( $c == $a || $c == $b);
            my @s = sort ($a, $b, $c);
            say "[ $a, $b, $c ]";
            $count++;
        }
    }
}
say "total $count combinations\n\n";

say "-" x 12;

## and again allowing repetitions but no permutation by enforcing an ascending order.
say "ascending ordered sets (no additional permutations): ";
$count = 0;
for $a ( 0..12 ) {
    for $b ( $a..12 ) {
        next if ($a + $b > 12);
        for $c ( $b..12 ) {
            next unless ($a + $b + $c == 12);
            say "[ $a, $b, $c ]";
            $count++;
        }
    }
}
say "total $count combinations\n\n";

