#!/usr/bin/perl
# Test: ./ch-1.pl 30
use strict;
use warnings;
use feature qw /say/;

say to_excel($ARGV[0]);

sub to_excel {
    my $n = shift;

    # Array to store digits
    my @digits;

    # Break down the digits to base 26
    while ($n > 0) {
    	push @digits, ($n-1) % 26;
    	$n = int(($n-1)/26);
    }

    # Join the digits
    return join '',
           map { chr(ord('A') + $_) }
           reverse @digits;
}
