#!/usr/bin/env perl
# Perl weekly challenge 380
# Task 2:  Reverse Degree
#
# See https://wlmb.github.io/2026/06/29/PWC380/#task-2-reverse-degree
use v5.36;
use feature qw(try);
use List::Util qw(sum0);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to find the reverse degree of string Sn
    FIN
my $z=ord("z")+1;
for(@ARGV){
    try {
	my $lc=lc $_;
	die "Expected English letters only: $_" unless $lc=~/^[a-z]*$/;
	my $position;
	say"$_ -> ", sum0 map { ++$position * ($z-ord $_)} split"";
    }
    catch($e){warn $e;}
}
