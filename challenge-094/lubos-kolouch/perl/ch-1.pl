#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge 094
#               Task 1
#               Group Anagrams
#
#       AUTHOR: Lubos Kolouch
#      VERSION: 1.0
#      CREATED: 01/06/2021 08:43:01 PM
#===============================================================================

use strict;
use warnings;


sub get_anagrams {
    my $what = shift;

    my %group;

    for my $elem (@$what) {
        my @sorted = sort split //, $elem;
        my $joined = join '', @sorted;

        push @{$group{$joined}}, $elem;
    }

    my @ret_arr = values %group;
    return \@ret_arr;
}


use Test::More;

my $result = get_anagrams(["opt", "bat", "saw", "tab", "pot", "top", "was"]);
is(scalar @$result, 3);

$result = get_anagrams(["x"]);
is(scalar @$result, 1);

done_testing;

