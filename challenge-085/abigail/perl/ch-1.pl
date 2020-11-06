#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# Challenge
#
# You are given an array of real numbers greater than zero.
#
# Write a script to find if there exists a triplet (a,b,c) such
# that 1 < a+b+c < 2. Print 1 if you succeed otherwise 0.
#

#
# A naieve implementation would be to check each triplet of numbers.
# That leads to a cubic algorithm.
#
# Better is to sort numbers, then for each pair of numbers check whether
# there is a third so that the sum of the three is between 1 and 2.
# If the array is sorted, we can find such a number in O (log N) time,
# resulting in a O (N^2 log N) run time.
#
# Also, if we sort the array (let's call the array a), we can restrict
# our search to triplets a [i], a [j], a[k], with i < j < k. That means,
# we can stop looking for a k if a [i] + 2 * a [j] >= 2.
#

my $MIN = 1;
my $MAX = 2;

#
# Find the largest number in $array which is smaller than $target,
# with index k, $min <= k < $max, or undef if there is not such a number.
#
sub binsearch ($array, $target, $min = 0, $max = @$array) {
    my $mid = int (($min + $max) / 2);

    return $min >= $max ||
           $$array [$min] >= $target ? undef
         : $min == $max - 1          ? $$array [$min]
         : $$array [$mid] >= $target ? binsearch ($array, $target, $min, $mid)
         :                             binsearch ($array, $target, $mid, $max)
}


LINE: while (<>) {
    #
    # Read the array of numbers, sort, and store them.
    #
    my $array = [sort {$a <=> $b} /[0-9.]+/g];

    #
    # Iterate over all pairs
    #
    for (my $i = 0; $i < @$array; $i ++) {
        #
        # If 3 * $$array [$i] >= $MAX, we cannot have any solutions,
        # as $$array [$j] >= $$array [$i] for $j > $i.
        #
        last if 3 * $$array [$i] >= $MAX;
        for (my $j = $i + 1; $j < @$array; $j ++) {
            #
            # If the sum of the first number and twice the second
            # exceeds the maximum, no triples with this pair will do.
            #
            last if $$array [$i] + 2 * $$array [$j] >= $MAX;
            my $sum2 = $$array [$i] + $$array [$j];

            #
            # Find a third number, if any. If we can find a suitable number,
            # it means we either have reached the end of the array, or all
            # numbers make it exceed the maximum sum.
            #
            my $third = binsearch $array, $MAX - $sum2, $j + 1;
            last unless defined $third;
            #
            # We still need to check whether we have exceeded the minimum value.
            #
            if ($MIN < $sum2 + $third) {
                #
                # Found suitable triple!
                #
                say 1;
                next LINE;
            }
        }
    }
    #
    # No suitable triples found.
    #
    say 0;
}

__END__
