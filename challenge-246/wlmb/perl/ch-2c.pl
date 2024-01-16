#!/usr/bin/env perl
# Perl weekly challenge 246
# Task 2:  Linear Recurrence of Second Order
# Third alternative: going back to integer math
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
my ($p, $q);
my $result;
if($x[0]==$x[1]==0){
    ($p,$q)=(0,0);
    $result=1;
}elsif($x[0]*$x[2]==$x[1]**2){
    # other singular matrix
    ($p,$q)=(0,$x[1]/$x[0]);
    $result = $x[1]%$x[0]==0;
}else{
    my $num_p = $x[2]**2-$x[3]*$x[1];
    my $num_q = $x[0]*$x[3]-$x[1]*$x[2];
    my $den = $x[0]*$x[2]-$x[1]**2;
    $result = $num_p%$den==0 && $num_q%$den==0; # coefficients are integer
    $p=$num_p/$den;
    $q=$num_q/$den;
}
$result &&= $x[$_]==$p*$x[$_-2]+$q*$x[$_-1] for (2..@x-1);
$result = $result?"True":"False";
say "@x => $result"
