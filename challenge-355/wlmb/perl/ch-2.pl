#!/usr/bin/env perl
# Perl weekly challenge 355
# Task 2:  Mountain Array
#
# See https://wlmb.github.io/2026/01/05/PWC355/#task-2-mountain-array
use v5.36;
use feature qw(try);
use PDL;
use PDL::NiceSlice;
die <<~"FIN" unless @ARGV;
    Usage: $0 A0 A1...
    to check if the array An is a mountain array.
    An is a string of the form "[N0 N1...]" where
    Ni correspond to numbers.
    FIN
for(@ARGV){
    try {
	my $x=pdl($_);
	my $result =
	    $x->ndims==1              # one dimensional array
	    && $x->nelem >= 3         # three or more elements
	    && (($x(1:-2) > $x(0:-3))& # larger than left neighbor
		($x(1:-2) > $x(2:-1)) # larger than right neighbor
	       )->any                 # one maximum at least
	    ;
	say "$_ -> ", $result?"True":"False";
    }
    catch($e){warn $e;}
}
