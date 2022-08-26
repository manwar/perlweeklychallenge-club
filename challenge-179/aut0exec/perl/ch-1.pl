#!/usr/bin/env perl
#
# You are given a positive number, $n.
# Write a script to spell the ordinal number.

use strict;
use warnings;

sub ones {
	my $value = shift;
	my %digit = ( 
	 0 => '', 1 => 'First', 2 => 'Second', 3 => 'Third', 4 => 'Fourth',
	 5 => 'Fifth', 6 => 'Sixth', 7 => 'Seventh', 8 => 'Eighth', 9 => 'Nineth'	
	);
	
	return "$digit{$value}\n";
}

sub teens {
	my $value = shift;
	my %digit = ( 
	 11 => 'Eleventh', 12 => 'Twelveth', 13 => 'Thirteenth', 14 => 'Fourteenth', 
	 15 => 'Fifteenth', 16 => 'Sixteenth', 17 => 'Seventeenth', 18 => 'Eighteenth', 
	 19 => 'Nineteenth'	
	);
	
	return "$digit{$value}\n";
}

sub tens {
	my $value = shift;
	my %digit = ( 
	0 => '', 2 => 'Twenty', 3 => 'Thirty', 4 => 'Forty', 5 => 'Fifty', 
	 6 => 'Sixty', 7 => 'Seventy', 8 => 'Eighty', 9 => 'Ninety'	
	);
	
	return "$digit{$value}";	
}

my $ordinal_num = shift;
my @ordinal = split (//,$ordinal_num);
my $dig_len = length($ordinal_num);

if ( $dig_len > 2 or $ordinal_num lt 1)
{ print ("$ordinal_num is invalid for this program!\n"); exit 1; }
elsif ( $dig_len == 1 )
{ print (ones($ordinal_num)); }
elsif ($ordinal[-2] == 1 and $dig_len < 3)
{ print (teens ($ordinal_num)); }
elsif ($ordinal[-2] != 1 and $ordinal[-1] == 0)
{ print (tens ($ordinal[-2]) . "\n"); }
else
{ print ( tens($ordinal[0]) . "-" . ones($ordinal[1]) ); }
