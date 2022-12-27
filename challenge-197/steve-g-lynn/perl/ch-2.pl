#!/usr/bin/env -S perl -wl

use strict;
use Data::Dumper qw(Dumper);

print Dumper(&wiggle_sort(1,5,1,1,6,4)); #5,6,1,4,1,1
print Dumper(&wiggle_sort(1,3,2,2,3,1)); #3,3,2,2,1,1
print Dumper(&wiggle_sort(1,2,3,4,5)); #4,5,2,3,1
print Dumper(&wiggle_sort(1,2,3,4)); #3,4,1,2

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


sub wiggle_sort {
    #-- subsub
    local *wiggle = sub {
        my ($n)=@_;
        ($n+1, $n);
    };

    #-- wiggle_sort root sub
    my @list = @_;
    my @retval;
    
    @list = sort {$b <=> $a} @list;
    
    for (my $i = 0; ($i <= (scalar(@list)-2)); $i += 2) {
        push @retval, @list[&wiggle($i)];    
    }
    (@list % 2) && (push @retval, $list[-1]);
    @retval; 
}

