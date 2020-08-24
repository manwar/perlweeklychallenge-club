#!/usr/bin/env perl6
# 
#
#       majority-ruler.raku
#
#       TASK #1 › Majority Element
#         Submitted by: Mohammad S Anwar
#         You are given an array of integers of size $N.
# 
#         Write a script to find the majority element. If none found then print -1.
# 
#         Majority element in the list is the one that appears more than floor(size_of_list/2).
# 
#         Example 1
#             Input: @A = (1, 2, 2, 3, 2, 4, 2)
#             Output: 2, as 2 appears 4 times in the list which is more than floor(7/2).
# 
#         Example 2
#             Input: @A = (1, 3, 1, 2, 4, 5)
#             Output: -1 as none of the elements appears more than floor(6/2).
# 
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub circumfix:<⎣ ⎦>( Numeric $n ) {
    $n.floor ;
}

unit sub MAIN (*@A);

@A = 1, 2, 2, 3, 2, 4, 2 if @A.elems == 0;
my %count;
%count{$_}++ for @A;

# is count of first elem count larger than half list size?
my $max = @A.max:{ %count{$_} };
say %count{$max} > ⎣@A.elems/2⎦ ?? $max !! -1 ;


