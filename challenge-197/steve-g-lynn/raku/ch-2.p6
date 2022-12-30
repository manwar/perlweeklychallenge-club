#!/usr/bin/env perl6


say &wiggle_sort((1,5,1,1,6,4)); #5,6,1,4,1,1
say &wiggle_sort((1,3,2,2,3,1)); #3,3,2,2,1,1
say &wiggle_sort((1,2,3,4,5)); #4,5,2,3,1
say &wiggle_sort((1,2,3,4)); #3,4,1,2

#-- this is not exactly the same as the challenge
#-- my interpretation is list[0] <= list[1] >= list[2] <= ..
#-- i.e., weak instead of strict inequalities
#-- otherwise, there may be no solutions
#-- e.g., with (1,1,1,1,1)
#
#-- also my algorithm does not generate the test examples
#-- though it generates answers that satisfy the (weaker)
#-- condition. 
#
#-- the logic is first sort in descending order
#-- then exchange the 1st and 2nd items, 3rd and 4th items, ...


sub wiggle_sort(@list) {
    my @retval;
    
    my @list_ = @list.sort({$^b <=> $^a}).flat;
    
    loop (my $i = 0; ($i <= (@list_.elems)-2); $i += 2) {
        push @retval, (@list_[&wiggle($i)]);    
    }
    (@list_ % 2) && (push @retval, @list_[*-1]);
    @retval.List.flat; 
}

#-- subsub
sub wiggle (Int $n) {
    $n+1, $n;
}
