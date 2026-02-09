#!/usr/bin/env perl
# Perl weekly challenge 360
# Task 1:  Text Justifier
#
# See https://wlmb.github.io/2026/02/08/PWC360/#task-1-text-justifier
use v5.36;
use feature qw(try);
use Scalar::Util qw(looks_like_number);
use integer;
die <<~"FIN" unless @ARGV && @ARGV%2==0;
    Usage: $0 S0 W0 S1 W1...
    to center string Si in a field of width Wi
    FIN
for my($string, $width)(@ARGV){
    try{
	my $length=length $string;
	die "Expected a number: $width" unless looks_like_number $width;
	die "Width $width is too small for string $string" unless $width>=$length;
	$string=~s/^\s*(.*)\s*$/$1/; # Remove leading and trailing spaces
	my $left = ($width- $length)/2;
	my $right = $width - $left-$length;
	say "\"$string\", $width -> ", "*" x $left, $string, "*" x $right;
    }
    catch($e){warn $e}
}
