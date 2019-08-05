#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
    qw{ experimental::postderef experimental::smartmatch experimental::signatures };

use DateTime;

# There are only 14 possible years, determined by leap year and starting
# day of week. If it starts on Monday on a leap year, there will be no 
# five-weekend months. 

my $table = {};
$table->{"01"} = [];
$table->{"02"} = [3];
$table->{"03"} = [8];
$table->{"04"} = [5];
$table->{"05"} = [ 1, 10 ];
$table->{"06"} = [7];
$table->{"07"} = [12];
$table->{"11"} = [3];
$table->{"12"} = [8];
$table->{"13"} = [5];
$table->{"14"} = [10];
$table->{"15"} = [ 1, 7 ];
$table->{"16"} = [12];
$table->{"17"} = [];

my $date = DateTime->now();
$date->set_day(1);
$date->set_month(1);
for my $year ( 1900 .. 2019 ) {
    $date->set_year($year);
    my $dow  = $date->day_of_week;
    my $leap = $date->is_leap_year;
    my $key  = join '', $leap, $dow;
    for my $month ($table->{$key}->@*) {
        say join '-', map { sprintf '%02d',$_ } $year, $month, '1';
    }
}

