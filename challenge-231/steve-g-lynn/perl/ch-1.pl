#!/usr/bin/env -S perl -wl

use PDL;
use PDL::NiceSlice;
use PDL::AutoLoader;

print &min_max(3,2,1,4); #[2,3]
print &min_max(3,1); #-1
print &min_max(2,1,3); #[2]

sub min_max {    
    my $ints=pdl(@_)->uniqvec;
    ($ints->dim(0) > 2) ? 
        ($ints->qsort->(1:(($ints->dim(0))-2))) : 
        (-1);
}
