#!/usr/bin/env perl6

my %temperature;

#-- read temperatures from file into hash
for '../temperature.txt'.IO.lines -> $line {
	$line.chomp;
	my ($date, $temperature) = $line.split(',');
	%temperature{$date}=$temperature;
}

for %temperature.keys.sort -> $datestring  {
	my $date=Date.new($datestring);
	my $prev_date = ($date-1).gist;
	
	%temperature{$prev_date}.defined || next;
	(%temperature{$datestring} > %temperature{$prev_date}) && $datestring.say;
}





