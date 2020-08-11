# Write a script to print the smallest pair of Amicable Numbers.
# For more information, please checkout wikipedia page.

use strict;
use warnings;
use v5.10;

# we start by defining a sub that sums of all divisors of a given number:

sub sum_divisors {
    my $x   = shift;
    my $sum = 0;
    for my $d ( 1 .. $x - 1 ) {
        $sum += $d unless $x % $d;
    }
    return $sum;
}

# now we will start calculating sum of divisors for each integer,
# starting by integer 2.
# we will name that integer $candidate, to show that is a potential
# amicable number, and we will try to get the corresponding pair
# and see if they accomplish the given criteria

my $candidate = 2;

while (1) {
    my $candidate2 = sum_divisors $candidate;

    # we will not consider cases where candidates are the same number
    # (that wouldn't be a pair, right?).
    # (Note also that this candidate would be a perfect number, something
    # we saw on challenge 008-1).
    # Also we don't care for candidates that are lower than the one
    # we are checking, as those would have been found before
    if ( $candidate < $candidate2 && $candidate == sum_divisors($candidate2) ) {
        say "Found amicable numbers: $candidate & $candidate2";
        last;    # challenge ask to stop on first match (i.e. smallest pair)
    }
    $candidate++;
}

# commenting out line # 38 above will get you a list of first
# amicable numbers. You can check that the first 10 pairs on that
# list match the ones listed on the wiki page:
#
# $> perl ch-2.pl
# Found amicable numbers: 220 & 284
# Found amicable numbers: 1184 & 1210
# Found amicable numbers: 2620 & 2924
# Found amicable numbers: 5020 & 5564
# Found amicable numbers: 6232 & 6368
# Found amicable numbers: 10744 & 10856
# Found amicable numbers: 12285 & 14595
# Found amicable numbers: 17296 & 18416
# Found amicable numbers: 63020 & 76084
# Found amicable numbers: 66928 & 66992
# Found amicable numbers: 67095 & 71145
# Found amicable numbers: 69615 & 87633
# Found amicable numbers: 79750 & 88730
# ^C
# $>
