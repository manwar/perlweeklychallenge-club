#!/usr/bin/env perl6

my @inputs=@*ARGS>0??@*ARGS!![10,20,20,51];

sub rank1224 (@inputs) {
	#my @d=reverse sort input;
	my @r=(for @inputs.kv {
		state $prev=-1;
		state $count=1;
		$count= $prev !== $^v ?? 1!! $count+1;
		$prev=$v;
		$^k;
		$k+2-$count;
	});
	#@r.elems +1 <<-<< @r.reverse
		
}
sub rank1334 (@inputs) {
	my @d=reverse @inputs;
	my @r=rank1224(@d);
	@r.elems +1 <<-<< @r.reverse
}

sub rank1223 (@input) {
	@input.map({
		state $prev=$_;
		state  $r=1;
		NEXT { $prev=$_};	
		$r= ($prev !== $_) ?? $r+1 !! $r;
		#say $r;
		$r;
	});
}

say rank1224(@inputs);
say rank1334(@inputs);
say rank1223(@inputs);
