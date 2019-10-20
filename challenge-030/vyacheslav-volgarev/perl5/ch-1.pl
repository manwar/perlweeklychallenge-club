#!/usr/bin/env perl

use strict;
use warnings;
use v5.10;

use constant {
	SUNDAY => 0,
	WEDNESDAY => 3
};

my $day = WEDNESDAY;

sub is_not_leap_year {
	my $year = shift;
	$year % 4 != 0 || ( $year % 100 == 0 && $year % 400 != 0 );
}

for ( 2020.. 2100 ) {
	$day += is_not_leap_year( $_ ) ? 1 : 2;
	$day %= 7;
	say "25 Dec $_ is Sunday" if $day == SUNDAY;
}
