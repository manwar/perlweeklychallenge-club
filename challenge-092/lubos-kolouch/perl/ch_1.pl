#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch_1.pl
#
#        USAGE: ./ch_1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge #092
#               Task 1 Isomorphic Strings
#
#       AUTHOR: Lubos Kolouch
#      VERSION: 1.0
#      CREATED: 12/25/2020 09:01:26 PM
#===============================================================================

use strict;
use warnings;
use Data::Dumper;

sub is_isomorphic {
    my $what = shift;

    my %char_map;

    my @arr1 = split //, $what->{'first'};
    my @arr2 = split //, $what->{'second'};

    for my $i (0..scalar @arr1-1) {
        $char_map{$arr2[$i]} //= $arr1[$i];
        $char_map{$arr1[$i]} //= $arr2[$i];

        return 0 unless $char_map{$arr1[$i]} eq $arr2[$i];
        return 0 unless $char_map{$arr2[$i]} eq $arr1[$i];
    }

    return 1;
}

use Test::More;

is(is_isomorphic({first => 'abc', second => 'xyz'}), 1);
is(is_isomorphic({first => 'abb', second => 'xyy'}), 1);
is(is_isomorphic({first => 'sum', second => 'add'}), 0);

done_testing;
