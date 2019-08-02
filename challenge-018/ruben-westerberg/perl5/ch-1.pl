#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw<sum>;
use v5.26;

my $s1=$ARGV[0]//"dfasabcdef";
my $s2=$ARGV[1]//"dfabcd";
my @a2=split "",$s2;
my $len2=@a2;
my @a1=split "",("_" x scalar @a2-1).$s1.("_"x scalar @a2-1);
push @a2, split "", "_" x (scalar @a1 -scalar @a2);
my $longest="";
my $maxCount=0;
my @rot=@a2; 

for (0..(scalar @a1 - $len2)) {
	my @tmp=map { ($a1[$_] eq $rot[$_] && $a1[$_] ne "_")?1:0} 0..$#rot;
	my $sum=sum @tmp;
	if ($sum > $maxCount) {
		$maxCount=$sum;
		$_=(join "", @tmp);
		while (/(1+)/g) {
			if (length $& > length $longest) {
				$longest=substr join("",@a1), $-[0],$+[0]-$-[0];
			}
		}
	}
	unshift @rot, pop @rot ;
}

print "Longest common substring: $longest\n";
