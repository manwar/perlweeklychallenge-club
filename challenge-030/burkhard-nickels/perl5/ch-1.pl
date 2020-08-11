#!/usr/bin/perl

use strict;
use warnings;
use DateTime;

for( my $i=2019; $i<=2100; $i++) {
	my $date = DateTime->new(
		year       => $i,
		month      => 12,
		day        => 25,
		hour       => 12,
		minute     => 0,
		second     => 0,
		time_zone  => 'Europe/Berlin',
	);
	print $date->dmy('.'), " is ", $date->day_name, "\n" if $date->day_name eq 'Sunday';
}



