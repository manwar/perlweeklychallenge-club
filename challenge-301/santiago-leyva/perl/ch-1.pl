=begin
You are given a list of positive integers, @ints.

Write a script to arrange all the elements in the given list such that they form the largest number and return it.

Example 1
Input: @ints = (20, 3)
Output: 320
Example 2
Input: @ints = (3, 30, 34, 5, 9)
Output: 9534330
=cut

use strict;
use warnings;
use Data::Dumper;

my @examples = ([20,3],[3, 30, 34, 5, 9]);

foreach(@examples){
    my @arr = @$_;
    my $result = arrangeNumbers(@arr);
    print "For [",join(" ",@arr),"] the result is -> $result \n";
}

sub arrangeNumbers {
    my @A = @_;
    my $length = scalar @A;

    #using Schartzian-transform
    my @sorted = map  { $_->[1] }
             sort { $b->[0] cmp $a->[0] }
             map  { [ $_ . $_, $_ ] } @A;  # Concatenate and keep original number

    return join("",@sorted);

}
