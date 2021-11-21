use strict;
use warnings;
##
# Implement JortSort
##
use boolean;

sub jort_sort{
    for(my $i=0; $i < @_ - 1; $i++){
        return false if $_[$i + 1] < $_[$i];  
    }  
    return true;
}

MAIN:{
    print jort_sort(1, 2, 3, 4, 5) . "\n";
    print jort_sort(1, 3, 2, 4, 5) . "\n";
}
