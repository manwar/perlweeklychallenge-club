#!/usr/bin/env perl
# Perl weekly challenge 256
# Task 1:  Maximum Pairs
#
# See https://wlmb.github.io/2024/02/12/PWC256/#task-1-maximum-pairs
use v5.36;
use List::Util qw(sum0);
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 [S2...]
    to pair Si with the reverse Sj and count the resulting pairs
    assuming at most one pair per string.
    FIN
my %count;
my $reverse;
for (@ARGV){
    ++$count{$_};
    my $reverse=reverse $_;
    --$count{$reverse} unless $reverse eq $_;
}
say "@ARGV -> ", (sum0 map {!$_} values %count)/2;
