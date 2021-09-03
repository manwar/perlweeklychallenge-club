#!/usr/bin/env perl
# Perl weekly challenge 128
# Task 1:  Maximum submatrix
#
# See https://wlmb.github.io/2021/08/30/PWC128/#task-1-maximum-submatrix
use warnings;
use strict;
use v5.12;
use List::Util qw(reduce);
use PDL;

my $m=(rcols *STDIN,[],{EXCLUDE=>'/^\s*$/'})->transpose; #input as pdl matrix
my ($x_max,$y_max)=map {$_-1} $m->dims;
# For each corner $i, $j find the best submatrix
my @sm; #array of submatrices
# For each possible corner produce submatrices
for my $i(0..$x_max){
    for my $j(0..$y_max){
	push @sm, submatrix($i,$j) if $m->at($i,$j)==0;
    }
}
# Choose the largest one
my $b=reduce {area(@{$a})>area(@{$b})?$a:$b} @sm;
# Output the results
say "Input: $m\nOutput: ",
    defined $b?"matrix($b->[0]:$b->[1],$b->[2]:$b->[3])=".
                $m->slice("$b->[0]:$b->[1],$b->[2]:$b->[3]")
              :"None";

sub area { # Calculate the area of a rectangular region given the ranges (a:b,c:d)
    my ($a, $b, $c, $d)=@_;
    return (1+$b-$a)*(1+$d-$c);
}

# Find the best submatrix left-and up-wards of a given corner
sub submatrix {
    # bottom right corner and current best upper left.
    my ($best_l, $best_t)=my ($right, $bottom)=@_;
    my $leftmost=-1; # Leftmost position to try
    my $top=-1;
    for (my $t=$bottom; $t>$top; --$t){
	my $l;
	for($l=$right;$l>$leftmost;--$l){
	    last unless $m->at($l,$t)==0;
	    ($best_l, $best_t)=($l, $t)
		if area($l,$right,$t, $bottom)
		> area($best_l, $right, $best_t, $bottom);
	}
	$leftmost=$l; # constrain next search
    }
    return [$best_l, $right, $best_t, $bottom] # corner coordinates
}
