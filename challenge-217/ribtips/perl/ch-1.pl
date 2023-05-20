#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

&main;

sub main {
    my @matrix=([3, 1, 2], [5, 2, 4], [0, 1, 3]);
    my $third_smallest=&convert_matrix(\@matrix);
    print "Output: $third_smallest\n";
    @matrix=([2,1],[4,5]);
    $third_smallest=&convert_matrix(\@matrix);
    print "Output: $third_smallest\n";
    @matrix=([1,0,3],[0,0,0],[1,2,1]);
    $third_smallest=&convert_matrix(\@matrix);
    print "Output: $third_smallest\n";
}

sub convert_matrix {
    my $matrix=shift;
    my @all=();
    foreach my $sub_array (@$matrix) {
        push @all,@$sub_array;
    }

    my @sorted = sort {$a <=> $b} @all;

    return($sorted[2]);;
}
