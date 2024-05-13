#!/usr/bin/env perl
# Perl weekly challenge 269
# Task 2:  Distribute Elements
#
# See https://wlmb.github.io/2024/05/13/PWC269/#task-2-distribute-elements
use v5.36;
die <<~"FIN" unless @ARGV>=2;
    Usage: $0 N1 N2...
    to redistribute the numbers N1 N2...
    FIN
my @in=@ARGV;
my @y=(shift);
my @z=(shift);
for(@ARGV){
    my $which=$y[-1]>$z[-1]?\@y:\@z;
    push @$which,$_;
}
say "@in->@y @z";
