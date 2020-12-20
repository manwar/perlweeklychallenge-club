#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch_1.pl
#
#        USAGE: ./ch_1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge #091
#               Task 1 - Count Number
#               www.perlweeklychallenge.org
#
#       AUTHOR: Lubos Kolouch
#      VERSION: 1.0
#      CREATED: 12/20/2020 10:27:07 AM
#===============================================================================

use strict;
use warnings;

sub as_we_read {
    my $what = shift;

    my $solution = '';

    my $pos = 1;
    my $count = 1;
    my $last_char = substr($what, 0, 1);

    while ($pos <= length($what)) {
        if (($pos == length($what)) or (substr($what, $pos, 1) != $last_char)) {
            $solution .= $count.$last_char;
            $count = 1;
            $last_char = substr($what, $pos, 1);
        } else {
            $count++;
        }


        $pos += 1;
    }

    return $solution;

}

use Test::More;

is(as_we_read(1122234), 21321314);
is(as_we_read(2333445), 12332415);
is(as_we_read(12345), 1112131415);

done_testing;
