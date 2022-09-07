#!/usr/bin/env perl

use strict;
use Date::Manip;

open TEMPERATURE, "../temperature.txt" || die "TEMPERATURE:$!\n";

my %temperature;

#-- read temperatures from file into hash
while (<TEMPERATURE>){
	chomp;
	my ($date, $temperature) = split(/,/,$_);
	$temperature{$date}=$temperature;
}

close TEMPERATURE;

#-- loop through hash
for my $datestring (sort keys %temperature) {
	my $prev_day = &prev_day($datestring);
	(($temperature{$prev_day})==undef) && next;
	($temperature{$prev_day} < $temperature{$datestring})
		&& print "$datestring\n";	
}

#-- get previous day
sub prev_day {
	my ($datestring)=@_;
	my $date=Date::Manip::Date->new();
	my $delta=$date->new_delta();
	$date->parse($datestring);
	$delta->parse('-1 day');
	my $prev_day = $date->calc($delta);
	$prev_day->printf('%Y-%m-%d');
}


1;


