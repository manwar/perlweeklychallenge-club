#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch_2.pl
#
#        USAGE: ./ch_2.pl  
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
            my $offset = 1;
            # work backwards and stop if we can jump over or at the beginning
            while ($pos - $offset  >= 0) {
                my $test_pos = $pos - $offset;

                my $elem_at_pos = $in_arr->[$pos - $offset];

                last if ($elem_at_pos + $pos - $offset > $pos);
                $offset++;
            } 

            return 0 unless $pos - $offset > 0;
        }
        $pos++;
    }

    return 1;

}

use Test::More;

is(jump([1, 2, 1, 2]), 1);
is(jump([2, 1, 1, 0, 2]), 0);
is(jump([2, 1, 2, 0, 2]), 1);
done_testing;
