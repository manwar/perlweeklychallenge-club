#!/usr/bin/env perl

use strict;
use warnings;
use Time::Piece;
use Time::Seconds;

my $t=Time::Piece->strptime("2019","%Y");
my %months;
while ($t->yy==19) {
	$months{$t->fullmonth}++ if ! ($t->wdayname =~ /Sat|Sun/);
	$t+=ONE_DAY;
}
print "$_: $months{$_}\n" for qw<January February March April May June July August September October November December>;
