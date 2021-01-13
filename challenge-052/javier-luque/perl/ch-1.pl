#!/usr/bin/perl
# Test: ./ch-1.pl 100 999
use strict;
use warnings;
use feature qw /say/;

my $start = $ARGV[0];
my $end   = $ARGV[1];

# Some input validation
unless ($start && $end && $end > $start &&
    $start >= 100 && $start < 1000 &&
    $end   >= 100 && $end < 1000) {

    say "Usage: 100 999";
    exit;
}

# Check each digit if it's stepping
for my $i ($start .. $end) {
    my $is_stepping = 1;
    my $prev_digit;

    my @digits = split ('', $i);
    for my $digit (@digits) {
    	$is_stepping = 0 if
    	( defined($prev_digit) &&
    		( $prev_digit != $digit + 1 &&
    		  $prev_digit != $digit - 1) );
    	$prev_digit = $digit;
    }
    say $i if ($is_stepping);
}
