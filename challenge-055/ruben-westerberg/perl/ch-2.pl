#!/usr/bin/env perl
use List::Util;
use v5.26;
my $n=$ARGV[0]//4;
my @number=1..$n;
my @waves=grep {

	my $res=1;
	while (my ($k,$v)=each @$_) {
		state $prev;
		unless ($k) {
			$prev=$v;
			next;
		}
		my $op=(($k%2)==0) ? 1 : -1;
		$res &&=($v-$prev)*$op > 0;
		last unless $res;
		$prev=$v;
	}
	$res?$_: ();
}
combinations(\@number,$n);
say join ",", @$_ for @waves;

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
