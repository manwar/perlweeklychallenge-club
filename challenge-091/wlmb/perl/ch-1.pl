#!/usr/bin/env perl
# Perl weekly challenge 091
# Task 1: Count Number
# Simple RLE encoding of a sequence of digits.
# See https://wlmb.github.io/2020/12/14/PWC91/#task-1-count-number
use warnings;
use strict;
use v5.10;
use List::Util qw(all);
use Scalar::Util::Numeric qw(isint);

die "Usage ./ch-1.pl n0 n1 ... to codify numbers n0 n1 ..." unless @ARGV;
die "Only non-negative numbers allowed" unless all {isint $_ == 1} @ARGV;

for my $N(map {int $_} @ARGV){
    print "Input:\t$N\nOutput:\t";
    my $current_digit=""; # Initialize to something printable
    my $current_count="";
    foreach(split(//, $N), "I'm not a digit"){ # digits and a unique stop marker
	if($current_digit ne $_  || $current_count eq 9){ # string comparisons
	    print "$current_count$current_digit";
	    $current_count=0;
	    $current_digit=$_;
	}
	++$current_count;
    }
    say "\n";
}
