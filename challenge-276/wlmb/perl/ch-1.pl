#!/usr/bin/env perl
# Perl weekly challenge 276
# Task 1:  Complete Day
#
# See https://wlmb.github.io/2024/07/01/PWC276/#task-1-complete-day
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 H1 H2...
    to find how many pairs of hours H1, H2... add up to complete days.
    FIN
my @counts;
$counts[$_%24]++ for @ARGV;
my $Npairs;
$Npairs += ($counts[$_]//0)*($counts[(-$_)%24]//0) for 1..11;
$Npairs += ($counts[$_]//0)*(($counts[$_]//0)-1)/2 for(0,12);
say "@ARGV -> $Npairs";
