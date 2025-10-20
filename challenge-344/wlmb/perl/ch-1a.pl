#!/usr/bin/env perl
# Perl weekly challenge 344
# Task 1:  Array Form Compute
# Number -> array form version
#
# See https://wlmb.github.io/2025/10/20/PWC344/#task-1-array-form-compute
use v5.36;
use feature qw(try);
use PDL;
die <<~"FIN" unless @ARGV && @ARGV%2==0;
    Usage: $0 A0 I0 A1 I1...
    to add the integer Ij to the integer in array form An
    and print the array form of the result.
    FIN
for my($string, $integer)(@ARGV){
    try {
	die "Input should be space separated positive integers within square brackets: $string"
	    unless $string =~ /^\[(\d|\s)*]$/;
	die "Input should be a positive integer" unless $integer=~/^\d+$/;
	my @array=pdl($string)->list;
	my @other=split "", $integer;
	my @result=();
	my $carry=0;
	while(@array||@other){
	    my $sum=((pop @array)//0)+((pop @other)//0)+$carry;
	    $carry=floor($sum/10);
	    unshift @result, $sum%10;
	}
	unshift @result, $carry if $carry;
	say "$string, $integer -> [@result]";
    }
    catch($e){ warn $e;}
}
