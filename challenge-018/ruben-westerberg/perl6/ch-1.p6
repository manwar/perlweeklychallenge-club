#!/usr/bin/env perl6


my $s1=@*ARGS[0]//"dfasabcdef";
my $s2=@*ARGS[1]//"dfabcd";
my @a2=$s2.comb;
my $len2=@a2.elems;
my @a1=("_" x @a2-1 ~$s1~ "_" x @a2-1).comb;
@a2=@a2.append: "_" xx @a1 - @a2;
my $longest="";
my ($maxShift,$maxCount)=(0,0);

for ^(@a1-($len2+1)) {
	my @tmp= ((@a1 >>eq<< @a2.rotate(-$_)) >>&&<< (@a1 >>ne>> "_"))>>.Num;
	my $sum=sum @tmp;
	if $sum > $maxCount {
		$maxCount=$sum;
		my @d=(m:g/(1+)/ given join "", @tmp)>>.&{@a1[.from.. .to-1].join: ""};
		$longest=@d.max;
	}
}

put "Longest common substring: $longest";

