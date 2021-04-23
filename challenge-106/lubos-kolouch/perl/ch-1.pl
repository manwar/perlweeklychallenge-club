#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge 106
#               Task 1 - Maximum Gap
#
#       AUTHOR: Lubos Kolouch
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 04/03/2021 12:59:25 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

sub get_max_diff {
    my $what = shift;

    return 0 unless scalar @$what > 1;

    my $max_diff = 0;
    my $prev = 0;

    for (sort @$what) {
        $max_diff = $_ - $prev if $_ - $prev > $max_diff;
        $prev = $_;
    }

    return $max_diff;
}

use Test::More;

is(get_max_diff([2, 9, 3, 5]), 4);
is(get_max_diff([1, 3, 8, 2, 0]), 5);
is(get_max_diff([5]), 0);

done_testing;
