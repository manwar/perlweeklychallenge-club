#!/usr/bin/env perl
# Week 180 Task 1
# Write a script to find out the first unique character in the given string
# and print its index (0-based).

use strict;
use warnings;
use Test::More;

ok(first_unique_character("Perl Weekly Challenge") == 0, "First");
ok(first_unique_character("Long Live Perl") == 1, "Second");
ok(first_unique_character("LOLOLx") == 5, "Last");
ok(!defined(first_unique_character("LOLO")), "None");
done_testing();

sub first_unique_character {
	my $s = shift;
	my $len = length $s;
	my $index = 0;
	while ( $index < $len) {
		my $c = substr $s, $index, 1;
		my $number = () = $s =~ /$c/gi;
		if ( $number == 1){
			last;
		}
		$index++;
		if ($index == $len) {
			undef $index;
			last;
		}
	}
	return $index;
}