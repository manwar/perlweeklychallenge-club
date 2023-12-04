#!/usr/bin/env perl
# Perl weekly challenge 246
# Task 2:  Linear Recurrence of Second Order
#
# See https://wlmb.github.io/2023/12/03/PWC246/#task-2-linear-recurrence-of-second-order
use v5.36;
use List::Util qw(all);
die <<~"FIN" unless @ARGV>=4;
    Usage: $0 N0 N1 N2 N3 [N4...]
    to check if the sequence of integers Ni obeys a linear second order recurrence with
    integer coefficients
    FIN
die "Arguments must be integer" unless all {/^[+-]?\d+$/} @ARGV;
my @x =@ARGV;
my $num_p = $x[2]**2-$x[3]*$x[1];
my $num_q = $x[0]*$x[3]-$x[1]*$x[2];
my $den = $x[0]*$x[2]-$x[1]**2;
my $result = $num_p%$den==0 && $num_q%$den==0; # coefficients are integer
my $p=$num_p/$den;
my $q=$num_q/$den;
$result &&= $x[$_]==$p*$x[$_-2]+$q*$x[$_-1] for (4..@x-1);
$result = $result?"True":"False";
say "@x => $result"
