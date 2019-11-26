#!/usr/bin/perl
use warnings;
use strict;
use Data::Validate::VIN;
use feature qw( say );

# Write a program to validate given Vehicle Identification Number (VIN).

# Gonna follow Larry's advise here and be lazy. CPAN!

my @vin = qw(JTHBE96S280041733 5YJSA1DP7DFP21717 5XXJSA1DP7DFP217171 5XXJSA1DP7DFP2172);
foreach (@vin) {
	my $v = Data::Validate::VIN->new($_);
 
	if ( $v->valid() ) {
	    say $v->get('vin'), " is valid.";
	}
	else {
	    say "$_" for @{ $v->errors() };
	}
}

__END__

./ch-1.pl
JTHBE96S280041733 is valid.
5YJSA1DP7DFP21717 is valid.
5XXJSA1DP7DFP217171 is not the expected length
Checkdigit mismatch; expected 0, got P
