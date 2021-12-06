#!/usr/bin/perl

use strict;
use warnings;

my $m = 1234;
my $n = 2;
likenumbers_divisible($m, $n);

sub likenumbers_divisible {
    my ($m, $n) = @_;

    my $length = length($m);
    my @likenumbers;
    my $divisible_count = 0;
    # Get all binary masks of length $length excluding all zeroes and all ones.
    foreach my $i (1 .. (2 ** $length)-2) {
    	my $mask = sprintf("%.${length}b", $i);
    	my $ministring = '';
    	#perform the masking operation to generate 23 from 1234 if mask is 0110.
    	foreach my $i (0 .. $length-1) {
    		$ministring .= substr($m, $i, 1) if substr($mask, $i, 1);
    	}
    	if ($ministring % $n == 0) {
    		$divisible_count++;
    	}
    }
    print "divisible_count: [$divisible_count]\n";
}
