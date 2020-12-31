#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch_1.pl
#
#        USAGE: ./ch_1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge #093
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-093/
#               Max Points 
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 12/30/2020 02:39:16 PM
#===============================================================================

use strict;
use warnings;
use feature qw/say/;
use List::Util qw/max/;
use Data::Dumper;

sub get_max_lines {
    my $what = shift;

    my $max_count = 0;


    for my $point (@$what) {
        my %slopes;

        for my $point2(@$what) {
            next if $point == $point2;
            my $slope;

            if ($point->[0] == $point2->[0]) {
                $slope = 'inf';
            } else {
                $slope = ($point->[1] - $point2->[1]) / ($point->[0] - $point2->[0]); 
            }

            $slopes{$slope}++;
        }
       
        $max_count = max($max_count, max values %slopes);
    }

    return $max_count + 1;
}

use Test::More;

is(get_max_lines([ [1,1], [2,2], [3,3] ]), 3);
is(get_max_lines([ [1,1], [2,2], [3,1], [1,3], [5,3] ]), 3);


done_testing();
