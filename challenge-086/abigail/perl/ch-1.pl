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
# You are given an array of integers @N and an integer $A.
#
# Write a script to find find if there exists a pair of elements in
# the array whose difference is $A.
#
# Print 1 if exists otherwise 0.
#

#
# This can be solved trivally by taking the difference of all
# pairs of numbers from @N, and see whether their difference
# equals $A. But that leads to a quadractic algorithm.
#
# We can also solve this in O (N log N) time. Wlog, assume $A
# is non-negative (which we can enforce by doing $A = abs $A).
# We first sort @N. Then we iterate over @N, and for each
# $N [i], we use a binary search to find a $N [j], j > i
# such that $N [j] = $A + $N [i];
#
# We will be using a similar binary search routine as we
# used in week 085.
#

#
# Return true if $array contain $target, with index >= $min,
# and index < $max.
#
sub binsearch ($array, $target, $min = 0, $max = @$array) {
    my $mid = int (($min + $max) / 2);

    return $min >= $max              ? 0
         : $$array [$mid] == $target ? 1
         : $$array [$mid] >  $target ?
                     binsearch ($array, $target, $min,     $mid)
         :           binsearch ($array, $target, $mid + 1, $max)
}


LINE: while (!eof ()) {
    #
    # Read data
    #
    my $data   = [sort {$a <=> $b} <> =~ /[0-9]+/g];
    my $target =  abs <>;

    #
    # Iterate over the data, use binary search for a match.
    #
    foreach my $i (keys @$data) {
        if (binsearch $data, $target + $$data [$i], $i + 1) {
            say 1;
            next LINE;
        }
    }
    say 0;
}


__END__
