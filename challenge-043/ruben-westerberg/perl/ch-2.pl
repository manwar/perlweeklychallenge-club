#!/usr/bin/env perl

use strict;
use warnings;
use v5.26;

my $base=$ARGV[0]||4;
my $i=baseToDec($base,"1"."0"x($base-1));#6210001000;
my $num=decToBase($base,$i);

while (length $num <= $base) {
	my $res=test($base,$num);
	if ($res) {
		print "***OK: $num***\n";
		sleep 1;
	}
	else {
		print "NO: $num\n";
	}
	$i++;
	$num=decToBase($base,$i);
}

sub baseToDec {
	my ($base,$value)=@_;
	my $sum=0;
	for (reverse split "", $value) {
		state $i=0;
		$sum+=$base**$i++*$_;
	}
	$sum;
}
sub decToBase {
	my ($base, $dec)=@_;
	return "0" if $dec==0;
	my $rem;
	my $result="";
	while ($dec) {
		$rem=$dec%$base;
		$result.=$rem<=9?$rem:chr(55+$rem);	
		$dec=int $dec/$base;
	}
	scalar reverse($result);
}

sub test {
	my ($base,$nString)=@_;
	return undef if length($nString) != $base;
	my $res=1;
	my @digits=split "", $nString;
	my $i=0;	
	for my $d(@digits) {
		my $count=scalar grep({$_ eq $i} @digits);
		my $bcount=decToBase($base,$count);	
		$res&&=(decToBase($base,$count) eq $d);
		last unless $res;
		$i++;
	}
	$res;
}
