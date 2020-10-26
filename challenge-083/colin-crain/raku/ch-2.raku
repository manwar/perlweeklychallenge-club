#!/usr/bin/env perl6
# 
#
#       flip-the-pain-away.raku
# 
#         TASK #2 › Flip Array
#         Submitted by: Mohammad S Anwar
#             You are given an array @A of positive numbers.
# 
#             Write a script to flip the sign of some members of the given array
#             so that the sum of the all members is minimum non-negative.
# 
#             Given an array of positive elements, you have to flip the sign of
#             some of its elements such that the resultant sum of the elements
#             of array should be minimum non-negative(as close to zero as
#             possible). Return the minimum no. of elements whose sign needs to
#             be flipped such that the resultant sum is minimum non-negative.
# 
#             Example 1:
#                 Input: @A = (3, 10, 8)
#                 Output: 1
#             Explanation:
#                 Flipping the sign of just one element 10 gives 
#                 the result 1 i.e. (3) + (-10) + (8) = 1
#         
#             Example 2:
#                 Input: @A = (12, 2, 10)
#                 Output: 1
#             Explanation:
#                 Flipping the sign of just one element 12 gives 
#                 the result 0 i.e. (-12) + (2) + (10) = 0

#
#       We pick a large number for our random pool
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (*@arr) ;
@arr.elems == 0 && @arr = (1..500).pick(10);

my $base_sum = @arr.sum;
my %results;

for 1..@arr.elems -> $k {

    my $min = $base_sum;
    my $pick;
    
    for @arr.combinations($k) -> $c {
        my $new_sum = $base_sum - 2 * $c.sum;
        if 0 <= $new_sum < $min {
            $min = $new_sum;
            $pick = $c;
        }
    }
    
    %results{$min} ||= $pick;
    last if $min == 0;                      ## we are done, cannot do better
    
}

%results{$base_sum}:delete;         
my $min = %results.keys.map(*.Int).min;     ## hash keys are strings
my @neg = %results{$min}.flat;

## strip negated elements from source array --> positive values only
my @pos = @arr;
for |@neg.list -> $ele {
    my $index =  @pos.first($ele, :k);
    @pos.splice($index,1);
}   

say "input array    : ", @arr;
say "min total      : ", $min;
say "negative values: ", |@neg.fmt: " -%d" ;
say "\n";
say @pos.join(' + ') ~ " " ~ @neg.fmt("- %d").join ~ " = $min";

