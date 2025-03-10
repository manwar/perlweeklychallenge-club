#!/usr/bin/env perl
# Perl weekly challenge 312
# Task 2:  Balls and Boxes
#
# See https://wlmb.github.io/2025/03/09/PWC312/#task-2-balls-and-boxes
use v5.40;
use List::Util qw(sum0 all);
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to count boxes with balls of all colors, where each strings Sn is of the form
    P1P2... with each pair Pj of the form Cb with C a color (R, G or B) and b a
    box number (0..9), meaning there is a ball of color C in box b.
    FIN
for(@ARGV){
    try {
	die "Wrong format: $_" unless /^([RGB]\d)*$/;
	my @boxes;
	for my($color, $box) (split ""){
	    ++$boxes[$box]{$color};
	}
	say "$_ -> ",sum0 map{all{$_}@{$boxes[$_]}{qw(R G B)}}(0..@boxes-1);
    } catch($e) {
	say $e;
    }
}
