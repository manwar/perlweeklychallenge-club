#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures };
no warnings qw{ experimental::signatures };

# generate the string of braces
my $string;
for ( 0 .. 1 + int rand 9 ) {
	$string .= int rand 2 ? '(' : ')';
}

# test if the string has matched braces
my $t = test_braces($string);
my $response = $t == 0 ? 'OK' : 'NOT OK';
say qq{$string - $response};

exit;

# The trick is a stack. When you get a "(", 
# you push onto the stack, and when get a ")",
# you pop from the stack. We special-case when
# the stack is empty and we get a ")", immediately
# returning -1, and then returning the number of 
# values in the array. A balanced array will return 
# 0

sub test_braces ( $string ) {
	my @x;
	for my $i ( split //, $string ) {
		return -1 if !scalar @x && $i eq ')';
		pop @x if scalar @x && $i eq ')';
		push @x, '' if $i eq '(';
	}
	return scalar @x;
}
