=begin
You are given an array of integers, @ints, where the largest integer is unique.

Write a script to find whether the largest element in the array is at least twice as big as every element in the given array. If it is return the index of the largest element or return -1 otherwise.

Example 1
Input: @ints = (2, 4, 1, 0)
Output: 1

The largest integer is 4.
For every other elements in the given array is at least twice as big.
The index value of 4 is 1.
Example 2
Input: @ints = (1, 2, 3, 4)
Output: -1

The largest integer is 4.
4 is less than twice the value of 3, so we return -1.
=cut

use strict;
use warnings;

my @input = ([2, 4, 1, 0],[1, 2, 3, 4]);

foreach(@input){
    my @arr = @$_;
    my $result = findLargestElementWithoutSort(\@arr);
    print "$result \n";
}

sub findLargestElementWithSort {
    my $array = shift;
    my @A = @$array;

    @A = sort{$a <=> $b}@A;
    my $biggest = pop @A;

    for(my $i = 0;$i<(scalar @A);$i++){
        return -1  if $A[$i]*2 > $biggest;
    }
    return 1;
}

sub findLargestElementWithoutSort {
    my $array = shift;
    my @A = @$array;
    my $is_valid = 1;
    my $biggest = undef;

    foreach my $num (@A) {
    if (!defined $biggest || $num > $biggest) {
        $biggest = $num;
        }
    }
    print "$biggest \n";
    foreach my $num (@A) {
        if ($num * 2 > $biggest && $num != $biggest) { #assuming no duplicates
            $is_valid = 0;
            return -1;
            }
    }

    return 1;
}
