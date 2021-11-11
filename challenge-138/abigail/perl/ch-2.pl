#!/opt/perl/bin/perl

use 5.028;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl < input-file
#

#
# We solve this with a recursive function. "can_split" gets two arguments,
# '$target', the number we have to achieve as a sum of parts, and
# '$number', the number we have to split into parts.
#
# If $target exceeds $number, we return 0, as we cannot split a number into
# parts and have it sum to something larger.
# If $target equals $number, we return 1, as we can trivial fulfill this.
#
# Else, we take ever larger parts from the end, subtract that part from
# $target, and recurse. If no part succeeds, we have a failure. If any
# part succeeds, we have a winner.
#
# Note that the only two numbers where the sqrt is equal to itself are
# 0 and 1 -- we have to exclude those as we need to split the original
# number into at least two parts. For all other numbers, its square root
# will be less, so not splitting the original number can't sum to the
# square root.
#

sub can_split ($target, $number) {
    return 0 if $target >  $number || $target < 0;
    return 1 if $target == $number;

    my $pow_10 = 10;
    #
    # We could use substring instead of modolu and division, but modulo
    # and division we can trivially port to other language solutions,
    # while taking substrings requires more work.
    #
    while ($pow_10 < $number) {
        use integer;
        return 1 if can_split ($target - ($number % $pow_10), 
                                          $number / $pow_10);
        $pow_10 *= 10;
    }

    return 0;
}

while (<>) {
    chomp;
    say $_ > 1 && can_split (sqrt ($_), $_) ? 1 : 0
}
