#!/usr/bin/perl

use strict;
use warnings;

sub least_distance {
	my ($char1, $char2) = @_;
	my $distance = abs(ord($char1) - ord($char2));
	if ($distance > 13) {
		$distance = 26 - $distance;
	}
	return $distance;
}

print('Enter any string: ');
my $str = <STDIN>;
chomp($str);
$str = lc $str;
my @str_chars = split //, $str;
my $total_distance = length($str);
if (substr($str,0,1) ne 'a') {
	unshift(@str_chars, 'a');
}
foreach my $i (0 .. $#str_chars - 1) {
	my $step_distance = least_distance($str_chars[$i], $str_chars[$i+1]);
	$total_distance += $step_distance;
}
print("Minimum distance: " . $total_distance . "\n");

# Mistakes done:
# Forgot to trim newline character at the end using chomp.
# Forgot the condition that the pointer starts from 'a'.