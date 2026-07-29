#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/384/1

use v5.26;    # The Weekly Challenge - 2026-07-27
use utf8;     # Week 384 - task 1 - Base n
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

base_n(493, 8);
base_n(15642094, 16);
base_n(42, 2);
base_n(1832913631, 87);
base_n(71 ** 9, 71);
base_n(100000, 27);
base_n(100000, 99);
base_n(4283337, 55);

sub base_n {

    my ($base, $number, $digits, $digit, $result);
    
    # initialise
    ($number, $base) = @_;
	say qq[\nInput:  \$number = $number base 10, new \$base = $base];
    $digits = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ' .
		'abcdefghijklmnopqrstuvwxyzαβγδεζηθικλμνξοπρςστυφχψω';
	if ($base < 2 or $base > length($digits)) {
		say qq[Output: base must be in 2 .. ] . length($digits);
		return;
	}
    $result = '';
    
    # strip digits 1 at a time
    while ($number) {
        $digit = $number % $base;
		$result = substr($digits, $digit, 1) . $result;
        $number = ($number - $digit) / $base;
     }
	say qq[Output: $result base $base];
}
