=begin
You are given a list of binary digits (0 and 1) and a positive integer, $n.

Write a script to return true if you can re-arrange the list by replacing at least $n digits with 1 in the given list so that no two consecutive digits are 1 otherwise return false.

Example 1
Input: @digits = (1, 0, 0, 0, 1), $n = 1
Output: true

Re-arranged list: (1, 0, 1, 0, 1)
Example 2
Input: @digits = (1, 0, 0, 0, 1), $n = 2
Output: false
=cut

use strict;
#use warnings;
use Data::Dumper;

my @nums = ([1, 0, 0, 0, 1],[1, 0, 1, 0, 1]);
my @limit = ([1],[2]);

foreach(0 ..scalar @nums -1){
    my @arr = @{$nums[$_]};
    my $number = $limit[$_][0];
    my $result = isRearrangeList(\@arr,$number);
    print "$result \n";
}

sub isRearrangeList {
    my ($S,$n) = @_;
    my @A = @$S;

    my $length = scalar @A;
    my $cur = $A[0];

    for(my $i=1;$i<$length;$i++){
        if($A[$i] != $cur){
            $cur = $A[$i];
            next;
        }else{
            $n--;
            $i += 1; #go to next
        }
    }
    return $n == 0 ? "True" : "False";

}