#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use v5.26;

my $string="123456789";
print "Input string to split and combine to 100: $string\n";
my @digits=split "",$string;
my $i=0;
my $limit=baseToDec(3,"100000000");
while ($i<$limit) {
	my $num=sprintf "%08s0",decToBase(3,$i++);
	my @ops=map {tr/120/+-/d;$_}  split "",$num;
	my $exp= join "",map {$digits[$_],$ops[$_]} 0..8;
	my $sum=eval $exp;
	print "sum: $sum from: $exp\n" if $sum==100;
}

#base conversion from last weeks challange
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
