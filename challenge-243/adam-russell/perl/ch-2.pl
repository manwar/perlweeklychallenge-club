use v5.38;
##
# You are given an array of positive integers (>=1). Write a script to 
# return the sum of 
#     floor(nums[i] / nums[j]) 
# where 
#     0 <= i,j < nums.length. 
# We define the floor() function as returning the integer part of the 
# division.
##
use POSIX;
sub floor_sum{
    my @integers = @_;
    my $floor_sum;
    do{
        my $i = $_;
        do{
            my $j = $_;
            $floor_sum += floor($integers[$i] / $integers[$j]);
        } for 0 .. @integers - 1;
    } for 0 .. @integers - 1;
    return $floor_sum;
}

MAIN:{
    say floor_sum 2, 5, 9;
    say floor_sum 7, 7, 7, 7, 7, 7, 7;
}
