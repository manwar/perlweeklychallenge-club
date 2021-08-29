#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: The Weekly Challenge #127
#               Task 1 - Disjoint Sets
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 08/27/2021 11:45:07 AM
#===============================================================================

use strict;
use warnings;


# Why Perl does not have a set type like Python?
# then it is an one-liner using set unions... 

sub compare_sets {
    my $what = shift;

    my %h1 = map{ $_ => 1} @{$what->[0]};
    my %h2 = map{ $_ => 1} @{$what->[1]};

    for my $key (keys %h1) {
        return 0 if $h2{$key};
    }

    return 1;
}

use Test::More;
is(compare_sets([[1, 2, 3], [3, 2, 1]]), 0);
is(compare_sets([[1, 2, 5, 3, 4], [4, 6, 7, 8, 9]]), 0);
is(compare_sets([[1, 3, 5, 7, 9], [0, 2, 4, 6, 8]]), 1);
done_testing();

