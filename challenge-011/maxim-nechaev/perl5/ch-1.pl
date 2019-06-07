#!/usr/bin/perl -w
use strict;
use feature 'say';

# function to find root
sub f {
    my $c = shift;		# celsius
    my $f = 9*$c/5 + 32;	# fahrenheit
    return $c - $f;
}

# see https://en.wikipedia.org/wiki/Bisection_method
my $a = -1000;		# begin interval
my $b = 1000;		# end interval
my $s = 1E-13;		# accuracy
my $x;			# root to find
do {
    $x = ($a + $b)/2;
    f($a) * f($x) < 0? $b = $x : $a = $x;
} while abs f($x) > $s;

say $x;		# -40
