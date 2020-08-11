#!/usr/bin/env perl

use warnings;
use strict;
use List::Util  qw<sum>;

use v5.26;

my @vins=@ARGV;
my %keys;
@keys{(0..9,"A".."H","J".."N", "P","R","S".."Z")}= (0..9,1..8,1..5,7,9,2..9);

my @weights=(reverse(2..8),10,0,reverse(2..9));

for (@vins) {
	my $i=0;
	print "Testing $_: ";
	my $result="OK";

	$result="Invalid digits present" unless /^[A-Z0-9]{17}$/;
	$result="Incorrect length" if length != 17;
	if ($result eq "OK") {
		my $check= sum( map { $keys{$_} * $weights[$i++]} split("",$_)) % 11;
		$check="X" if $check == 10;
		
		$result = "Invalid VIN number" if ($check ne substr($_,8, 1));
	}
	print "$result\n";
}
