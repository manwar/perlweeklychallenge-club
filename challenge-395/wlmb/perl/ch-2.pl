#!/usr/bin/env perl
# Perl weekly challenge 395
# Task 2:  Word Squares
#
# See https://wlmb.github.io/2026/10/18/PWC395/#task-2-word-squares
use v5.36;
use feature qw(try);
use List::Util qw(all);
die <<~"FIN" unless @ARGV;
    Usage: $0 L0 L1...
    to make a square with the space separated words
    in list Ln.
    FIN
for(@ARGV){
    try {
	my @words = split " ";
	die "At least one word is required" unless @words >=1;
	die "Null words are not allowed"
	    unless all {length $_ > 0} @words;
	die "Only upper case ASCII words allowed"
	    unless all {/^[A-Z]+$/} @words ;
	die "All words should be of the same length"
	    unless all {length $_ == length $words[0]};
	die "The number of words should be larger than their length"
	    unless @words >= length $words[0];
	say "@words -> ", join " ", build([], [@words]);
    }
    catch($e){warn $e}
}

sub build($current, $rest){
    return @$current if 0 < @$current && @$current == length $current->[0]; # done
    for(0 .. @$rest - 1){
	my @result;
	my @testing = (@$current, $rest->[$_]);
	test(@testing)
	    && (@result = build([@testing], [@$rest[0..$_-1], @$rest[$_+1..@$rest-1]]))
	    && return @result;
    }
    return;
}
sub test(@t){
    my $i=@t-1;
    for my $j(0..$i){
	substr($t[$i], $j, 1) eq substr($t[$j], $i, 1)
	    || return 0;
    }
    return 1;
}
