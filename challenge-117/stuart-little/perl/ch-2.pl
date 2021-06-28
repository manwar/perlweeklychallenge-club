#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <number>

use feature qw(signatures);
no warnings qw(experimental::signatures);

use Math::Cartesian::Product;

my @memo=([''],['R','LH']);

sub mkPaths($size) {
    ($size > $#memo) && do {
	my @res = map {'R' . $_} @{mkPaths($size-1)};
	for my $nr (0..$size-1) {
	    my @gluedPairs = map {'L' . $_->[0] . 'H' . $_->[1]} cartesian {1} mkPaths($nr), mkPaths($size -1 - $nr);
	    push @res, @gluedPairs;
	}
	push @memo, \@res;
    };
    return $memo[$size];    
}

for (@{mkPaths($ARGV[0])}) {
    say;
}
