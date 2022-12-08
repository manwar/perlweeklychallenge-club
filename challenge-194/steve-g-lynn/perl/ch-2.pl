#!/usr/bin/env perl

use strict;
use warnings;

use List::Util qw(min max);

print frequency_equalizer('abbc'),"\n"; #1
print frequency_equalizer('xyzyyxz'),"\n"; #1 
print frequency_equalizer('xzxz'),"\n"; #0


sub frequency_equalizer {
    my ($s) = @_;
    
    my @s = split (//, $s);
    
    my (%s, %uniq);
    
    for my $i (@s) {
        $s{$i}++;
    }

    for my $i (values %s) {
        $uniq{$i} = $i;
    }
    
    @s = sort keys %uniq;
    
    ( (scalar(@s)==2) && (min(@s)==(max(@s)-1)) ) &&
        (return 1);
    
    return 0; 
}

