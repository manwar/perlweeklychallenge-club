#!/usr/bin/env perl
# Perl weekly challenge 357
# Task 2:  Unique Fraction Generator
#
# See https://wlmb.github.io/2026/01/19/PWC357/#task-2-unique-fraction-generator
use v5.36;
use feature qw(try);
use Math::Prime::Util qw(gcd);
use Algorithm::Combinatorics qw(variations_with_repetition);
use Text::Wrap;
$Text::Wrap::columns=60;
die <<~"FIN" unless @ARGV;
    Usage: $0 N0 N1...
    to sort and print all proper fractions than can be built
    with the integers 1..Nn
    FIN
for(@ARGV){
    try{
	die "Expected a positive integer: $_" unless /^\+?\d+$/;
	say wrap("", "    ",
		 "$_->",
		 map{"$_->[0]/$_->[1]"}
		 sort{$a->[0]*$b->[1]<=>$a->[1]*$b->[0]}
		 grep{gcd(@$_)==1}
		 variations_with_repetition [1..$_],2
	    );
    }
    catch($e){warn $e;}
}
