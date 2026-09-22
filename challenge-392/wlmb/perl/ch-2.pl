#!/usr/bin/env perl
# Perl weekly challenge 392
# Task 2:  Words Length Product
#
# See https://wlmb.github.io/2026/09/20/PWC392/#task-2-words-length-product
use v5.36;
use List::Util qw(max);
die <<~"FIN" unless @ARGV;
    Usage: $0 L0 L1...
    to find the maximum product of the lengths of
    two words with no common letters taken from the space
    separated lists Ln.
    FIN
for(@ARGV){
    my @words = split " ";                   # get list of words
    say"$_ -> ",
	max                                  # maximize
	0,                                   # default value
	map {                                # products of lengths
	    my ($x,$y) = @$_;
	    length($x)*length($y);
        }
        grep{
	    my ($x,$y) = @$_;
	    my $re = join "|", split "", $x; # i.e., convert abc to regular expression a|b|c
	    !($y =~ m/$re/)                  # match means letters in common, reject pair
        }
        map {                                # build pairs of words
	    my $w1 = $_;
	    map { [$w1, $_] } @words
       } @words;
}
