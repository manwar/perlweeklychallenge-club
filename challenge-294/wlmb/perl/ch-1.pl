#!/usr/bin/env perl
# Perl weekly challenge 294
# Task 1:  Consecutive Sequence
#
# See https://wlmb.github.io/2024/11/04/PWC294/#task-1-consecutive-sequence
use v5.36;
use List::Util qw(max);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 N2...
    to find the length of the longest consecutive sequence
    that may be built from the (possibly disordered) numbers
    N1, N2...
    FIN
my $length = 0;
my %bounds;
for(@ARGV){
    my $previous = $bounds{$_-1};
    my $next = $bounds{$_+1};
    my $lower = defined($previous)? $previous->[0] : $_;
    my $upper = defined($next)? $next->[1] : $_;
    $bounds{$lower}[0] = $bounds{$upper}[0] = $lower;
    $bounds{$lower}[1] = $bounds{$upper}[1] = $upper;
    $length = max $length, $upper-$lower
}
my $result = $length? $length+1 : -1;
say "@ARGV -> ", $result;
