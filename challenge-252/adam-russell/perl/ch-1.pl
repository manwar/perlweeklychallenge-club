use v5.38;
##
# Given an array of integers, @ints write a script to find the sum of 
# the squares of all special elements of the given array.
# An element $int[i] of @ints is called special if i divides n, 
# where n is the length of the given array. Consider the array to be 
# 1-indexed for this task. 
## 
sub special_numbers{
    my $r;  
    do{
        $r += $_[$_] * $_[$_]  if @_ % ($_ + 1) == 0; 
    } for 0 .. @_ - 1;  
    return $r; 
}

say special_numbers 1, 2, 3, 4;
say special_numbers 2, 7, 1, 19, 18, 3;
