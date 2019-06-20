#!/usr/bin/env perl
use strict;
use warnings;
use v5.24;
use Time::Piece;
use Time::Seconds;
my $d=Time::Piece->strptime($ARGV[0], "%Y");
$d+= (12-$d->day_of_week)*ONE_DAY;
my $year=$d->year;
while ($d->year == $year) {
	state $prev=$d;#-ONE_MONTH;
	$prev=$d;
	$d+=ONE_WEEK;
	if ($d->monname ne $prev->monname ){
		print $prev->ymd("/")."\n";
	}
	
}

