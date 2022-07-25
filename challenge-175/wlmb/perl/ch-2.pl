#!/usr/bin/env perl
# Perl weekly challenge 175
# Task 2: Perfect totient numbers
#
# See https://wlmb.github.io/2022/07/25/PWC175/#task-2-perfect-totient-numbers
use v5.36;
use List::Util qw(sum);
use Math::Prime::Util qw(euler_phi);
die "Usage: $0 N\nto print the first N perfect totient numbers\n"
    unless @ARGV;
say "$_: ", next_perfect_totient() for(1..shift);
sub next_perfect_totient{
    state $current=1;
    ++$current;
    ++$current until $current==sum recursive_totients($current);
    $current
}
sub recursive_totients($m){ #(totient(m), totient(totient($m))...)
    my $t=euler_phi($m);
    $m==2?($t):(recursive_totients($t), $t)
}
