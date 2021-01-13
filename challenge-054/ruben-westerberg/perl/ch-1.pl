#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(switch say);
no warnings 'experimental';
use List::Util;


my ($n,$k)=($ARGV[0]//3, $ARGV[1]//4);

#Error checking. Limit the value of k to the maximum permutation count
die "n and k must be >= 1)" if $n < 1 or $k < 1;
my $pCount= factorial($n);
die "k must be lest than n! =  $pCount" if $k>$pCount;

#actually select the kth permutation
my @perm=sort {$a > $b} map {join "", @$_} combinations([1..$n], $n);
say $perm[$k-1];



sub factorial {
	my ($n)=@_;
	do {
		given ($n) {
			1 when 0;
			default {
				List::Util::reduce { $a*$b} 1..$n;
			}
		}
	}
}

sub combinations {
	my @combinations=();
	my ($data,$size)=@_;
	my @indexes=(0) x ($size+1);;
	my $i=0;
	until ($indexes[$size]) {
		my $count=List::Util::uniq(@indexes[0..$size-1]);
		push @combinations, [@$data[@indexes[0..$size-1]]] if $count == $size;
		$indexes[0]++;
		for (0..$size-1) {
			if ($indexes[$_] != 0 and 0 == ($indexes[$_] % @$data)) {
				$indexes[$_]=0;
				$indexes[$_+1]++;
			}
		}
	}
	@combinations;
}

