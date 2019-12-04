#!/usr/bin/perl
use warnings;
use strict;
use DateTime;
use DateTime::Duration;
use feature 'say';

# Write a script to calculate the total number of weekdays (Mon-Fri) in each month of the year 2019.

my $year = shift;

do {
        print <<EOU;
Usage:
$0 year
        $0 2019
        $0 2020
EOU
        exit;
} unless $year;

use constant {
        SATURDAY => 6,
        SUNDAY   => 7,
};

my $dt = DateTime->new('year' => $year, 'month' => 1, 'day' => 1);
my $day = DateTime::Duration->new('days' => 1);
my $month = $dt->month;
my $weekday_count = 0;
do {
	print $dt->month_abbr;

	do {
		$weekday_count++ if ($dt->day_of_week != SUNDAY and $dt->day_of_week != SATURDAY);
		$dt->add( $day );
	} until ($dt->month != $month);

	say ": $weekday_count";

	$month = $dt->month;
	$weekday_count = 0;

} until ($dt->year != $year);


__END__

./ch-1.pl
Usage:
./ch-1.pl year
        ./ch-1.pl 2019
        ./ch-1.pl 2020

./ch-1.pl 2019
Jan: 23
Feb: 20
Mar: 21
Apr: 22
May: 23
Jun: 20
Jul: 23
Aug: 22
Sep: 21
Oct: 23
Nov: 21
Dec: 22

./ch-1.pl 2020
Jan: 23
Feb: 20
Mar: 22
Apr: 22
May: 21
Jun: 22
Jul: 23
Aug: 21
Sep: 22
Oct: 22
Nov: 21
Dec: 23
