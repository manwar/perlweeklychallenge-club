#!/usr/bin/env perl
# Perl weekly challenge 196
# Task 2:  Range List
#
# See https://wlmb.github.io/2022/12/19/PWC196/#task-2-range-list
use v5.36;
use List::Util qw(all pairmap);

say(<<"FIN"), exit unless @ARGV > 0;
Usage: $0 N1 [N2...]
to identify subsequences of contiguous intgers
FIN
say("Expected integer arguments"), exit unless all {/^[+-]?\d+$/} @ARGV;
my @input=my @rest=sort {$a <=> $b} @ARGV; # make sure list is sorted and make copies
my $previous=my $first=shift @rest;
say join " ", @input, "->",
    pairmap {"[$a, $b]"}
    map{subseq($_)} @rest, undef; # finish inputs with undef

sub subseq($current){ # identify and output complete contiguous subsequences
    my @output = $first<$previous ? ($first, $previous): ();
    return @output if
        !defined $current      # input is consumed
	&& $first < $previous; # and a range has been found
    $previous = $current, return () if $current==$previous+1; # not done yet
    $first=$previous=$current; # prepare next sequence
    return @output;
}
