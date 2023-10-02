#!/usr/bin/env perl
# Perl weekly challenge 218
# Task 2:  Matrix Score
#
# See https://wlmb.github.io/2023/05/22/PWC218/#task-2-matrix-score
use v5.36;
use PDL;
use PDL::NiceSlice;
use experimental qw(try);
say <<~"FIN" unless @ARGV;
    Usage: $0 M1 M2...
    to find the score of matrices M1, M2...,
    where each M is of the form [[b_11, b_12...],[b_21, b_22...]...]
    and each b_ij is a bit (0 or 1)
    FIN
my $p;
for(@ARGV){
    try {
	my $x=pdl($_);
	die "Matrix should be binary" unless (($x==0)|($x==1))->all;
	$p=2**$x->xvals->(-1:0);  # descending powers of 2, to convert from bit matrix to decimal
	my $y;
	$x=$y while(defined ($y=convert($x))); # Make as many conversions as possible
	say "$_ -> ", value($x);
    }
    catch($e){
        say "$e: $_";
    }
}

sub convert($x){
    for(0,1){ # rows or columns
	my $s=$_ ? ":," : "";  # argument to slice second or first dimension
	for(0..$x->dim($_)-1){ # for each column or each row
	    my $y=$x->copy;    # make a copy of the argument
	    $y("$s$_").=!$y("$s$_"); # complement the bits of the row or column
	    return $y if value($y)>value($x); # return modified matrix if value changed
	}
    }
    return;  # undef if no conversion found, done
}

sub value($z){   # turn binary matrix into number
    ($z*$p)->sum
}
