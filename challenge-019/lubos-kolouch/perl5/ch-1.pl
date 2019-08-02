#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl
#
#  DESCRIPTION: Task #1
#
#  Task #1
#  Write a script to display months from the year 1900 to 2019 where you find 5 weekends i.e. 5 Friday, 5 Saturday and 5 Sunday.
#
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch,
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 07/29/2019 08:48:27 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw{ say };
use Data::Dumper;
use Date::Calc qw/check_date Day_of_Week Days_in_Month/;

sub has_5_weekends {
    my ( $year, $month ) = @_;

    my $days = Days_in_Month( $year, $month );

    my %wdays;

    for my $day ( 1 .. $days ) {
        $wdays{ Day_of_Week( $year, $month, $day ) }++;
    }

    return 1 if ( $wdays{5} == 5 ) and ( $wdays{6} == 5 ) and ( $wdays{7} == 5 );

    return 0;
}

###### MAIN ######

my $count;

for my $year ( 1900 .. 2019 ) {
    for my $month ( 1 .. 12 ) {
        $count++ if has_5_weekends( $year, $month );
    }

}

say "There are $count months";
###### TESTS ######

use Test::More;

say 'TESTS:';

is( has_5_weekends( 2019, 7 ), 0, 'Test 2019/07' );
is( has_5_weekends( 2019, 3 ), 1, 'Test 2019/03' );

done_testing;
