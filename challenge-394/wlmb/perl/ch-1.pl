#!/usr/bin/env perl
# Perl weekly challenge 394
# Task 1:  Alternate Case
#
# See https://wlmb.github.io/2026/10/05/PWC394/#task-1-alternate-case
use v5.36;
use utf8;
use feature qw(try);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to count the number of adjacent transpositions required to
    turn the string Sn into alternate case. Sn should contain the same number
    of upper and lower case letters.
    FIN
for(@ARGV){
    try {
        my $in=$_;
        die "Expected even sized string: $in" unless length($_) % 2 == 0;
        die "Extraneous character found: $in" unless /^[A-Za-z]*$/;
        s/[A-Z]/0/g;
        s/[a-z]/1/g;
        my $sum=(my $test=$_)=~tr/1/x/;
        die "Unbalanced string: $in" unless $sum*2 == length;
        my $count=0;
        ++$count while
	       s/0011/0101/
	    || s/^011/101/
	    || s/001$/010/
	    || s/1100/1010/
	    || s/^100/010/
	    || s/110$/010/
	    || s/011|110/101/
	    || s/100|001/010/;
        say "$in -> $count";
    }
    catch($e){
        warn $e;
    }
}
