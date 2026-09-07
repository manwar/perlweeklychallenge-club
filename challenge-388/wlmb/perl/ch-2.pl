#!/usr/bin/env perl
# Perl weekly challenge 388
# Task 2:  Secret Santa
#
# See https://wlmb.github.io/2026/08/24/PWC388/#task-2-secret-santa
use v5.36;
use Memoize;
sub derange($n){
    die "Argument should be non-negative: $n" if $n<0;
    return 1 if $n==0;
    return $n*derange($n-1)+($n%2==0?1:-1);
}
die <<~"FIN" unless @ARGV;
    Usage: $0 N0 N1...
    to find the number of derangements of Ni elements
    FIN
memoize qw(derange);
say "$_ -> ", join " ", derange $_ for @ARGV;
