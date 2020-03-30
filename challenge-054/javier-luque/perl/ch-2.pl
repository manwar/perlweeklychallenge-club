#!/usr/bin/perl
# Test: ./ch-2.pl
use strict;
use warnings;
use feature qw /say/;

# Brute force calculate collatz
my %lengths;
for my $i (1 .. 1_000_000) {
    my $length = collatz($i);
    $lengths{$i} = $length
    	if ($length > 440);
}

# Grab the 22 longest numbers
my @keys = (
    sort {
    	$lengths{$b} <=> $lengths{$a}
    } keys %lengths
)[0 .. 21] ;

for my $i ( @keys ) {
    say "$i : Length " . $lengths{$i};
}

#Calculate collatz
sub collatz {
    my $n = shift;
    my $length = 0;

    while ($n != 1) {
    	$length++;

    	$n = ($n % 2) ?
    		3 * $n + 1  :
    		$n / 2;
    }

    return $length;
}
