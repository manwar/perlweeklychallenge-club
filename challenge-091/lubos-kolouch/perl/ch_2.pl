#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch_1.pl
#
#        USAGE: ./ch_1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge #091
#               Task 2 - Jump Game
#               www.perlweeklychallenge.org
#
#       AUTHOR: Lubos Kolouch
#      VERSION: 1.0
#      CREATED: 12/20/2020 10:27:07 AM
#===============================================================================

use strict;
use warnings;

sub jump {
    my $in_arr = shift;

    # test if each zero can be overjumped
    
    my $pos = 0;
    for my $num (@$in_arr) {
        if ($in_arr->[$pos] == 0) {
            my $back = 0;
            # work backwards and stop if we can jump over or at the beginning
            while ( ($pos >= 0) and ($in_arr->[$pos] + $pos - $back > $pos) ) {
                $back--;
            } 

            return 0 unless $back;
        }
        $pos++;
    }

    return 1;

}

use Test::More;

is(jump([1, 2, 1, 2]), 1);
is(jump([2, 1, 1, 0, 2]), 0);

done_testing;
