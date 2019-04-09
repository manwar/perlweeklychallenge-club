#!/usr/bin/env perl
my $b=35;
foreach (@ARGV) {
	my $power=0;
	while (int($_/ $b**++$power) >= 1){};
	$power--;
	my @out=();
	while ($power >= 0) {
		my $place=$b**$power;
		my $val=int($_ / $place);
		my $digit= $val >= 10 ?  chr(ord('A')+($val-10)) : $val;
		push @out, $digit;
		$_= $_- $place*$val;
		$power--;
	}
	$base35=join "", @out;
	print "Base 35: $base35\n";
	my $place=  length $base35;
	$_=reverse $base35;
	my $sum=0;
	while(--$place >=0){
		$val=chop $_;
		$sum += $b**$place * (scalar (grep ($_ eq $val, "A".."Y")) ? (ord($val)-55) : $val);
	}
	print "Base 10: $sum\n";
} 
