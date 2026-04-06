#!/usr/bin/env perl
# Perl weekly challenge 368
# Task 2:  Big and Little Omega
#
# See https://wlmb.github.io/2026/04/06/PWC368/#task-2-big-and-little-omega
use v5.36;
use feature qw(try);
use Math::Prime::Util qw(factor factor_exp);
die <<~"FIN" unless @ARGV && @ARGV%2 == 0;
    Usage: $0 N0 M0 N1 M1...
    to count prime factors of the number Nn according to the mode Mm.
    If Mn is 0 count distinct factors. If Mn is 1, count all factors
    FIN
my @function = (\&factor_exp, \&factor);
for my($number, $mode)(@ARGV){
    try {
	die "Invalid number: $number" unless $number =~ /^\d+$/;
	die "Invalid mode: $mode" unless $mode==0 || $mode==1;
	my $result = $function[$mode]->($number);
	say "number=$number, mode=$mode -> ", $result;
    }
    catch($e){ warn $e; }
}
