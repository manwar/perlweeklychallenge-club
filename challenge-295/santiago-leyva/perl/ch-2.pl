=begin
You are given an array of integers, @ints.

Write a script to find the minimum number of jumps to reach the last element. $ints[$i] represents the maximum length of a forward jump from the index $i. In case last element is unreachable then return -1.

Example 1
Input: @ints = (2, 3, 1, 1, 4)
Output: 2

Jump 1 step from index 0 then 3 steps from index 1 to the last element.
Example 2
Input: @ints = (2, 3, 0, 4)
Output: 2
Example 3
Input: @ints = (2, 0, 0, 4)
Output: -1
=cut

use strict;
use List::Util qw(max);

my @j = ([2, 3, 1, 1, 4],[2, 3, 0, 4],[2, 0, 0, 4]);

foreach (@j) {
    my @input = @$_;
    my $result = findJumps(\@input);
    print "For [ ",join(" ",@input)," ] -> jumps: $result\n";
}

sub findJumps {
    my $arr = shift;
    my @A = @$arr;
    my $res = 0;
    my ($l, $r) = (0,0); #breath first search sides
    my $farthest;
    while($r < (scalar @A)-1){
        $farthest = 0;
        foreach my $i ($l..($r)){
            $farthest = max($farthest,($i+$A[$i]));
        }
        $l = $r + 1;
        $r = $farthest;
        $res += 1;
        return -1 if ($r == 0 and $r <(scalar @A));
    }

    return $res;

}