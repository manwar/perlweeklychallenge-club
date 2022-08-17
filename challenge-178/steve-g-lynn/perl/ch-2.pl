#!/usr/bin/env perl

use Date::Manip;
#https://metacpan.org/pod/Date::Manip

print &print_date_plus_duration('2022-08-01 10:30','in 4 business hours'),"\n";

#22-08-01 14:30

print &print_date_plus_duration('2022-08-01 17:00','in 3.5 business hours'),"\n";

#22-08-02 11:30

sub print_date_plus_duration {
	my ($datestr,$deltastr)=@_;
	my $date = new Date::Manip::Date;
	my $delta = $date->new_delta();
	$date->parse($datestr);
	$delta->parse($deltastr);

	return $date->calc($delta)->printf('%y-%m-%d %H:%M');
}

