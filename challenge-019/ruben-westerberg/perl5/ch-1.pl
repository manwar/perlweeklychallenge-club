#!/usr/bin/env perl
use strict;
use warnings;
use Time::Piece;
use Time::Seconds;
use List::Util qw<any>;
use v5.26;

my $s= Time::Piece->strptime("1900","%Y");
my $e= Time::Piece->strptime("2019","%Y");
#Find the months with 5 weekends (5 fridays, 5 saturdays and 5 sundays).
#This is only possible when
#  --month has 31 days
#  --must start with a Friday
# 
# Search by day as only one day will ever match the start of a month

while ($s < $e) {
	print $s->strftime("%Y %B"), "\n" 
	if ($s->mday==1) && ($s->day_of_week==5) && any {$s->mon == $_ } (1,3,5,7,8,10,12);
	$s+=ONE_DAY;
}
