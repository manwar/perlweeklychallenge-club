#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-03-02
use utf8;     # Week 363 - task 2 - Subnet sheriff
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

# test limits of subnet
my $subnet = '192.168.1.0/24';
subnet_sheriff('192.168.1.45', $subnet);   # typical
subnet_sheriff('192.168.1.0', $subnet);    # first
subnet_sheriff('192.168.1.255', $subnet);  # last
subnet_sheriff('192.168.2.0', $subnet);    # outside
subnet_sheriff('1.1.1.1', '1.1.255.1/24'); # invalid

# examples from challenge
subnet_sheriff('192.168.1.45', '192.168.1.0/24'); # true
subnet_sheriff('10.0.0.256', '10.0.0.0/24');    # invalid
subnet_sheriff('172.16.4.5', '172.16.0.0/14');  # true
subnet_sheriff('192.0.2.0', '192.0.2.0/25');    # true

# smallest and largest subnets
subnet_sheriff('1.2.3.4', '1.2.3.4/32'); # true
subnet_sheriff('1.2.3.4', '0.0.0.0/0');  # true

sub subnet_sheriff {
	
	my ($address, $domain, $good, $domain2, $mask, $within, $address2);
	
	# initialise
	($address, $domain) = @_;
	say qq[\nInput:  \$address = '$address', \$domain = '$domain'];
	
	# validate address
	unless ($address =~ m|([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})|
		and $1 <= 255 and $2 <= 255 and $3 <= 255 and $4 <= 255) {
		say qq[Output: false - invalid address];
		return;
	}
	$address2 = ($1 * 2**24) + ($2 * 2**16) + ($3 * 2**8) + $4;
	
	# validate domain
	$good = $domain =~ m|([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})/([0-9]{1,2})| ? 1 : 0;
	$good = ($good and $5 <= 32);
	if ($good) {
		$domain2 = $1 * (2 ** 24) + $2 * (2 ** 16) + $3 * (2 ** 8) + $4;
		$mask = (2 ** $5 - 1) << (32 - $5);
		$good = ($domain2 & $mask) == $domain2;
	}
	unless ($good) {		
		say qq[Output: false - invalid subnet];
		return;
	}
	
	# check that address falls within subnet
	$within = ($address2 & $mask) == $domain2 ? 'true' : 'false - address outside subnet';
	
	say qq[Output: $within];
}

