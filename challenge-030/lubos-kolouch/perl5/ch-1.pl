#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-030/
#
#  Write a script to list dates for Sunday Christmas between 2019 and 2100. For example, 25 Dec 2022 is Sunday.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 20.10.2019
#     REVISION: ---
#===============================================================================


# This script has a problem - Christmas is celebrated on different days in
# different countries. For example in CZ the main day is 24.12. in the evening
# and there are public holidays 24-25-26. But let's stick to 25...

use strict;
use warnings;
use feature qw/say/;
use DateTime;

sub is_sunday_date {
    my $year = shift;
    my $dt=DateTime->new(
        year => $year,
        month => 12,
        day => 25,);

    $dt->day_of_week == 7 ?1:0;
}

sub main {

    for (2019..2100) {
        say "25.12.$_" if is_sunday_date($_);
    }
}

main;

# TESTS

use Test::More;

is (is_sunday_date(2022),1,'Test for 2022');
is (is_sunday_date(2021),0,'Test for 2022');
done_testing;

