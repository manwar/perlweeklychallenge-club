#!/usr/bin/env perl
# Perl weekly challenge 349
# Task 2:  Meeting Point
#
# See https://wlmb.github.io/2025/11/24/PWC349/#task-2-meeting-point
use v5.36;
use feature qw(try);
use List::Util qw(zip);
use PDL;
die <<~"FIN" unless @ARGV;
    Usage: $0 P0 P1...
    to find if the path Pn returns to the starting points.
    Each path is a string with the letters U, D, L and R, indicating
    a step up, down, left and right.
    FIN
my %movements=map{$_->[0], pdl $_->[1]} zip [qw(U D R L)], [[0,1], [0,-1], [1,0], [-1,0]];
for(@ARGV){
    try {
	die "The only allowed letters are U, D, L, and R: $_" unless /^[UDLR]*$/;
	my $result = "False";
	my $current = pdl[0,0];
	for(split ""){
	    $current += $movements{$_};
	    $result = "True", last unless any($current);
	}
	say "$_ -> $result";
    }
    catch($e){warn $e;}
}
