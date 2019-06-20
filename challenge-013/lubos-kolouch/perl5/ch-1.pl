#!/usr/bin/perl 
#===============================================================================
#
#         FILE: 2019w25.pl
#
#        USAGE: ./2019w25.pl  
#
#  DESCRIPTION: Perl weekly challenge w25
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-013/
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 06/20/2019 09:06:41 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use Date::Calc qw/check_date Day_of_Week/;
use 5.020;

my $year = shift // die 'No year passed';

for my $month (1..12) {
    my $day = 31;

    while ($day) {
        $day-- until check_date($year, $month, $day);

        if (Day_of_Week($year, $month, $day) == 5) {
            say $year.'/'.$month.'/'.$day;
            $day = 1;
        }
        $day--;
    }
}


