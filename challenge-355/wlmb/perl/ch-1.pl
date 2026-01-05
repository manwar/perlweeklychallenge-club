#!/usr/bin/env perl
# Perl weekly challenge 355
# Task 1:  Thousand Separator
#
# See https://wlmb.github.io/2026/01/05/PWC355/#task-1-thousand-separator
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV;
    Usage: $0 N0 N1...
    to separate the integers Nn in groups of three digits.
    FIN
for(@ARGV){
    try {
	die "Only digits allowed" unless /^\d+$/;
	my $in=$_;
	1 while s/(\d)(\d{3})(,|$)/$1,$2$3/; # insert commas, right to left
	say "$in -> $_";
    }
    catch($e){ warn $e }
}
