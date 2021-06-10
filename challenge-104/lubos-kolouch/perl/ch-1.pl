#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge 104
#               Task1 - FUSC fuscuence
#       AUTHOR: Lubos Kolouch
#      VERSION: 1.0
#      CREATED: 03/20/2021 10:42:13 AM
#===============================================================================

use strict;
use warnings;

sub get_fusc {
    my $what = shift;

    my %fusc = ( 0 => 0, 1 => 1 );

    for my $i (2..$what - 1) {
        if ($i % 2 == 0) {
            $fusc{$i} = $fusc{$i / 2}
        } else {
            $fusc{$i} = $fusc{($i-1)/2} + $fusc{($i+1)/2}
        }
    }

    return [@fusc{0 .. $what-1}];
}

use Test::More;

is_deeply(get_fusc(5), [0, 1, 1, 2, 1]);
is_deeply(get_fusc(50), [0, 1, 1, 2, 1, 3, 2, 3, 1, 4, 3, 5, 2, 5, 3, 4, 1, 5, 4, 7, 3, 8, 5, 7, 2, 7, 5, 8, 3, 7, 4, 5, 1, 6, 5, 9, 4, 11, 7, 10, 3, 11, 8, 13, 5, 12, 7, 9, 2, 9]);
done_testing;


