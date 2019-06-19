#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-06-17
# Week: 013
# Challenge: #1
#
# Write a script to print the date of last Friday of every month of a
# given year. For example, if the given year is 2019 then it should
# print the following:
# 2019/01/25
# 2019/02/22
# 2019/03/29
# 2019/04/26
# 2019/05/31
# 2019/06/28
# 2019/07/26
# 2019/08/30
# 2019/09/27
# 2019/10/25
# 2019/11/29
# 2019/12/27

use strict;
use warnings;
use feature qw / say /;
use DateTime;
use Test::Simple tests => 3;

ok( get_first_day_of_year(2019) == 3, "First day of 2019 is a Tuesday" );
ok( get_first_day_of_year(2005) == 0, "First day of 2005 is a Saturday" );
ok( get_first_friday_of_year(2019)->strftime("%Y/%m/%d") eq "2019/01/04",
    "Date of first friday in 2019 is 2019/01/04." );

my @all = get_last_fridays_of_month_for_year(2019);
for (@all) {
    say $_->strftime("%Y/%m/%d");
}

sub get_last_fridays_of_month_for_year {
    my $year        = shift;
    my @all_fridays = get_all_fridays_for_year($year);
    my @last_fridays;
    for (@all_fridays) {
        $last_fridays[ $_->month - 1 ] = $_;
    }
    return @last_fridays;
}

sub get_all_fridays_for_year {
    my $year   = shift;
    my $friday = get_first_friday_of_year($year);
    my @all_fridays;
    while ( $friday->year() == $year ) {
        push @all_fridays, $friday->clone();
        $friday->add( weeks => 1 );
    }
    return @all_fridays;
}

sub get_first_friday_of_year {
    my $year         = shift;
    my $first_friday = 7 - get_first_day_of_year($year);
    my $dt           = DateTime->new(
        year  => $year,
        month => 1,
        day   => $first_friday,
    );
    return $dt;
}

sub get_first_day_of_year {
    my $year = shift;
    my $y    = $year - 1;
    my $m    = 13;
    my $d    = 1;
    my $N
        = $d
        + ( 2 * $m )
        + int( 3 * ( $m + 1 ) / 5 )
        + $y
        + int( $y / 4 )
        - int( $y / 100 )
        + int( $y / 400 )
        + 2;
    return $N % 7;    # 0 .. 6 represents Saturday .. Friday
}
