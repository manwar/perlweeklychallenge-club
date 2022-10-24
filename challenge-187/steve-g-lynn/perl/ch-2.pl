#!/usr/bin/env perl

use List::Util qw(sum);

&print_list(&magical_triplet(1,2,3,2));
#3 2 2

&print_list(&magical_triplet(1,3,2));
#

&print_list(&magical_triplet(1,1,2,3));
#

&print_list(&magical_triplet(2,4,3));
#4,3,2



sub magical_triplet(@n){
    

    #-- find the three biggest elements (Their sum is max)
    my @candidate = (sort {$b <=> $a} @_)[0 .. 2];
    
    #-- test if any element is >= than the sum of the other two
    my $sum=sum @candidate;
    for my $i (@candidate) { ($i >= ($sum-$i)) && (return ()) }
    
    #-- if no element is >= the sum of the other two, we are through.
    return @candidate;
}

sub print_list {
    print "@_\n";
}

