#!/usr/bin/env perl
# Perl weekly challenge 102
# Task 1: Rare numbers
# Slightly faster through a reduction of the search space, but more elaborate.
#
# See https://wlmb.github.io/2021/03/01/PWC102/#task-2-rare-numbers
use strict;
use warnings;
use v5.12;
use POSIX qw(floor);

my %shown; # to avoid showing repetitions

for my $N(@ARGV){
    my($A, $B, $P, $Q); #first, second, next to last and last digits
    ($A, $Q)=(2,2); #explore possible combinations
    for $B(0..9){
	search($N, $A, $B, $B, $Q);
    }
    ($A, $Q)=(4,0);
    for $B(0..9){
	for $P(map {($B+2*$_)%10} (0..4)){
	    search($N, $A, $B, $P, $Q);
	}
    }
    $A=6;
    for $Q(0,5){
	for $B(0..9){
	    for $P(map {($B+1+2*$_)%10} (0..4)){
		search($N, $A, $B, $P, $Q);
	    }
	}
    }
    ($A, $Q)=(8, 2);
    for $B(0..9){
	$P=9-$B;
	search($N, $A, $B, $P, $Q);
    }
    ($A, $Q)=(8, 3);
    for $B(0..9){
	$P=($B-7)%10;
	search($N, $A, $B, $P, $Q);
    }
    ($A, $Q)=(8, 7);
    for $B(0..9){
	$P=(1-$B)%10;
	search($N, $A, $B, $P, $Q);
    }
    ($A, $Q)=(8, 8);
    for $B(0..9){
	$P=$B;
	search($N, $A, $B, $P, $Q);
    }

sub search{ #search $N digit numbers given first and last digits
	my ($N, $A, $B, $P, $Q)=@_;
	# return if $N<=3;
	test(join '', $A, $Q) if $N==2;
	test(join '', $A, $B, $Q) if $N==3;
	test(join '', $A, $P, $Q) if $N==3 && $P!=$B;
	test(join '', $A, $B, $P, $Q) if $N==4;
	return unless $N>4;
	my $format="%0".($N-4)."d";
	for my $m(map {sprintf($format, $_)} (0..10**($N-4)-1)){ #generate middle digits
	    test(join '',$A, $B, $m, $P, $Q);
	}
    }
    sub test { #test and report the single number
	my $x=shift;
	return if $shown{$x};
	# return if $x%10==0; #uncomment to disallow reversed numbers starting in 0
	my $y=join '', reverse split '', $x;
	return if $x<=$y; #use < to allow palindromes
	my $s=$x+$y;
	return unless $s==floor(sqrt($s))**2; # test squareness of sum
	my $d=$x-$y;
	return unless $d==floor(sqrt($d))**2; # test squareness of diff
	++$shown{$x};
	my $N=length $x;
	say "N=$N\tx=$x\ty=$y\tx+y=$s=", sqrt($s),"**2\tx-y=$d=",sqrt($d),"**2";
    }
}
