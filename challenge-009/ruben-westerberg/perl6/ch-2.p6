#!/usr/bin/env perl6

my @inputs=@*ARGS>0??@*ARGS!![10,20,20,51];
@inputs.=sort;
sub rank1224 (@inputs) {
	#my @d=reverse sort input;
	my @r=(for @inputs.kv {
		state $prev=$^v;
		state $count=0;
		NEXT {$prev=$v};
		$count= $prev !== $^v ?? 1!! $count+1;
		$^k+2-$count;
	});
}
sub rank1334 (@inputs) {
	my @d=reverse @inputs;
	my @r=rank1224(@d);
	@r.elems +1 <<-<< @r.reverse
}

sub rank1223 (@input) {
	@input.map: {
		state $prev=$_;
		state  $r=1;
		NEXT { $prev=$_};	
		$r= ($prev !== $_) ?? $r+1 !! $r;
	};
}
say "Inputs: "~@inputs;
say "1224 Ranking: "~rank1224(@inputs);
say "1334 Ranking: "~rank1334(@inputs);
say "1223 Ranking: "~rank1223(@inputs);
