#!/usr/bin/env perl

use strict;
use warnings;

use Algorithm::Combinatorics qw(combinations);
use List::Util qw(sum);

print &divisible_pairs(2,4,5,1,6),"\n"; #2
print &divisible_pairs(2,1,2,3,4),"\n"; #2
print &divisible_pairs(3,1,3,4,5),"\n"; #2
print &divisible_pairs(4,5,1,2,3),"\n"; #2
print &divisible_pairs(4,7,2,4,5),"\n"; #1

sub divisible_pairs {
    my ($k,@list)=@_;
 
    my $ctr=0;   
    for my $i (combinations(\@list,2)) {
        ((sum @$i) % $k == 0) && ($ctr++)
    }
    return $ctr;
}

