#!/usr/bin/env perl

use Date::Manip::Recur;

my $dates = &last_sunday(2022);

foreach my $date (@$dates) {
	print $date->printf("%Y-%m-%d"),"\n";
}

sub last_sunday {
	my ($year)=@_;
	my $recur = new Date::Manip::Recur;

	$recur -> parse("last Sunday of every month in $year");
	my @dates=$recur->dates();
		
	return \@dates;
}

1;
