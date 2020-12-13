#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch_2.pl
#
#        USAGE: ./ch_2.pl  
#
#  DESCRIPTION: Perl Weekly Challenge #090
#               Task 2
#               Ethiopian Multiplication 
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 12/13/2020 02:07:44 PM
#===============================================================================

use strict;
use warnings;


sub multiply {
    my $input = shift;

    my $first = $input->{first};
    my $second = $input->{second};

    my $result = 0;

    while ($first > 1) {
        $first = int($first / 2);
        $second *= 2;

        $result += $second;
    }

    return $result;
}
use Test::More;

is(multiply({first => 14, second => 12}), 168);

done_testing;
