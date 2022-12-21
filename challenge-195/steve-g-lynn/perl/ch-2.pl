#!/usr/bin/env -S perl -wl

use List::Util qw(min max);

use strict;

print &most_frequent_even((1,1,2,6,2)); #2
print &most_frequent_even((1,3,5,7)); #-1
print &most_frequent_even((6,4,4,6,1)); #4;


sub most_frequent_even {

    my (@list) = @_;

    (my @evens = grep {($_ % 2) == 0} @list )  || (return -1);
 
    my %bag;
    for (@evens) {
        $bag{$_}++;
    }
 
    my $max_freq = max values %bag;
    
    @evens = grep {$bag{$_} == $max_freq} keys %bag;
    
    min @evens;
   
}
