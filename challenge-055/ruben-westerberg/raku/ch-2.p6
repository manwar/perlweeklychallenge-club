#!/usr/bin/env raku

my $n=@*ARGS[0]//4;
my $number=1..$n;
my @waves=gather {
	for $number.permutations -> $p {
		my $res=True;
		for $p.kv -> $k, $v {
			state $prev;
			unless $k {
				$prev=$v;
				next;
			}
			my $op=$k%%2??1!!-1;
			$res and= ($v-$prev)*$op > 0;
			last unless $res;
			$prev=$v;
		}
		take $p if $res;
	}
}
.say for @waves;
