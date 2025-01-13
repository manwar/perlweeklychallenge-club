#!/usr/bin/env perl
# Perl weekly challenge 304
# Task 2:  Maximum Average
#
# See https://wlmb.github.io/2025/01/13/PWC304/#task-2-maximum-average
use v5.36;
use List::Util qw(sum0 max);
use POSIX qw(floor);
die <<~"FIN" unless @ARGV>=2;
    Usage: $0 N I1 I2...
    to find the maximum average of coutiguous subarrays of Ii with N elements.
    FIN
my $n=shift;
die "N should be >=1: $n" unless floor($n)>=0;
$n=floor($n);
my @i=@ARGV;
my $first = sum0 @i[0..$n-1];
my @changes = map{$i[$_+$n]-$i[$_]} (0..@i-$n);
unshift @changes, 0;
my $max_change=max @changes;
my $max_sum=$first + $max_change;
my $max_avg = $max_sum/$n;
say "$n, ( @i ) -> $max_avg";
