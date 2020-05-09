#!/usr/bin/perl

use strict;
use warnings;

my $L = [ 1, 4, 3, 2, 5, 2 ];
my $K = 3;
my $O = split_list($L, $K);

print sprintf("Input:  [ %s ]\n", join (" -> ", @$L));
print sprintf("Output: [ %s ]\n", join (" -> ", @$O));

sub split_list {
    my ($L, $K) = @_;

    my $before = [];
    my $after  = [];
    foreach my $i (@$L) {
        if ($i < $K) {
            push @$before, $i;
        }
        else {
            push @$after, $i;
        }
    }

    return [ @$before, @$after ];
}
