#!/usr/bin/env perl
# Perl weekly challenge 312
# Task 1:  Minimum Time
#
# See https://wlmb.github.io/2025/03/09/PWC312/#task-1-minimum-time
use v5.36;
use List::Util qw(min);
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to find the time required to print the strings S1 S2...
    using a daisy typerwriter
    FIN
my $ord_a = ord("a");
my $Nletters=1 + ord("z") - $ord_a;
for(@ARGV){
    my $time=length;
    my $current=0;
    my $difference;
    ($difference, $current) =($current-$_, $_),
	$time += min($difference % $Nletters, -$difference % $Nletters)
	for map {(ord)-$ord_a } split "";
    say "$_ -> $time"}
