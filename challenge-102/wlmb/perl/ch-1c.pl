#!/usr/bin/env perl
# Perl weekly challenge 102
# Task 1: Rare numbers
# Faster by breaking the number at the middle.
use strict;
use warnings;
use v5.12;
use POSIX qw(floor);

foreach my $N(@ARGV){
    my $min=10**($N-1);
    my $N2=floor($N/2);
    my $M=10**$N2;
    my %seen; # disctint squares mod $M
    foreach my $a(0..10**$N2){
	$seen{($a**2)%$M}=1;
    }
    my @squares=sort {$a<=>$b} keys %seen;
    foreach my $a2(@squares){
	foreach my $b2(@squares){
	    my $xr=($a2+$b2);
	    next unless $xr%2==0;
	    $xr=sprintf("%0${N2}d",($xr/2)%$M);
	    my $xl1=sprintf("%0${N2}d",(($a2-$b2)/2)%$M);
	    foreach my $mid($N%2==0?(''):(0..9)){
		my $x=join '', reverse(split '', $xl1), $mid, $xr;
		next unless $x>=$min;
		my $y=join '', reverse(split '', $x);
		next unless $x>$y;
		my $s=$x+$y;
		my $d=$x-$y;
		next unless floor(sqrt($s))**2==$s;
		next unless floor(sqrt($d))**2==$d;
		say "N=$N\tx=$x\ty=$y\tx+y=$s=", sqrt($s),"**2\tx-y=$d=",sqrt($d),"**2";
	    }
	}
    }
}
