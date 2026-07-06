#!/usr/bin/env perl
# Perl weekly challenge 381
# Task 2:  Smaller Greater Element
#
# See https://wlmb.github.io/2026/07/06/PWC381/#task-2-smaller-greater-element
use v5.36;
use feature qw(try);
use PDL;
die <<~"FIN" unless @ARGV;
    Usage: $0 A0 A1...
    to count the elements of the array An that are both strictly larger
    and smaller than some other elements. An is a string that can be
    fed to PDL as an array
    FIN
for(@ARGV){
    try {
	my $array = pdl $_;
	die "Expected a 1D array; $_" unless $array->ndims==1;
	my ($min, $max) = $array->minmax;
	say "$_ -> ", $array->where(($array != $min) & ($array != $max))->nelem;
    }
    catch($e){ warn $e; }
}
