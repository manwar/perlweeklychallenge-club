#!/usr/bin/env perl6


say &twice-largest([1,2,3,4]); #-1
say &twice-largest([1,2,0,5]); #1
say &twice-largest([2,6,3,1]); #1
say &twice-largest([4,5,2,3]); #-1

sub twice-largest (@list) {
    my @sorted_list = @list.sort({$^b <=> $^a});
    ((@sorted_list[0]) >= (2*@sorted_list[1]))  ?? 1 !! (-1);
}

