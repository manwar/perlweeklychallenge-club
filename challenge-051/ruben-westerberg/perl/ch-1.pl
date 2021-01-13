#!/usr/bin/env perl
use strict;
use warnings;
no warnings "experimental";
use feature "switch";
use List::Util;
my @list=(-25, -10, -7, -3, 2, 4, 8, 10);
my $target=0;

#my @combinations=combinations(\@list,3);
my @triplets=grep {my @s=sort(@$_); @s ~~ @$_ } 
grep { List::Util::sum(@$_)==$target} 
combinations(\@list,3);

printf "3 Sum triplet: %s+%s+%s=%s\n", @$_,$target for (@triplets);

sub combinations {
	my @combinations=();
	my ($data,$size)=@_;
	my @indexes=(0) x ($size+1);;
	my $i=0;
	until ($indexes[$size]) {
		my $count=List::Util::uniq(@indexes[0..$size-1]);
		#print $count,"\n";;
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
