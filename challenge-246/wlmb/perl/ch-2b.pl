#!/usr/bin/env perl
# Perl weekly challenge 246
# Task 2:  Linear Recurrence of Second Order
# Second alternative: using SVD
#
# See https://wlmb.github.io/2023/12/03/PWC246/#task-2-linear-recurrence-of-second-order
use v5.36;
use PDL;
use List::Util;
die <<~"FIN" unless @ARGV>=4;
    Usage: $0 N0 N1 N2 N3 [N4...]
    to check if the sequence of integers Ni obeys a linear second order recurrence with
    integer coefficients
    FIN
die "Arguments must be integer" unless List::Util::all {/^[+-]?\d+$/} @ARGV;
my ($pq, $uncertain)=is_linear_2(@ARGV);
my $result=defined $pq && test_pq($pq, @ARGV);
my $certain=$uncertain? "Probably ": "";
$result=$certain . $result?"True":"False";
say "@ARGV -> $result";

sub is_linear_2(@x){
    my $m=pdl[[$x[0], $x[1]],[$x[1], $x[2]]];
    my ($U, $D, $V)=svd($m); # singular value decomposition
    my $result;
    my $sol;
    my $rhs=pdl[$x[2], $x[3]];
    if($D->slice([0,0,0])->approx(0)){ # null matrix
	return pdl(0,0) if(($rhs==0)->all);
	return;
    }
    if($D->slice([1,0,0])->approx(0)){ # singular matrix
	return unless $V->slice([1,0,0])->inner($rhs)->approx(0);
        return pdl(0, $x[1]/$x[0]);
    }
    my $d_inv=zeroes(2,2); # not singular
    $d_inv->diagonal(0,1).=1/$D;
    $sol=($V x $d_inv x $U->transpose x $rhs->dummy(0))->squeeze;
    return $sol if $sol->approx($sol->rint)->all; # check integer
}

sub test_pq($pq, @x){
    my $x=pdl(@ARGV);
    my $previous_two=pdl($x->slice([0,-3]),$x->slice([1,-2]))->transpose;
    return $x->slice([2,-1])->approx($pq->inner($previous_two))->all;
}
