#!/usr/bin/env perl6

sub MAIN (Bool :$decode=False) {	
	$*OUT.out-buffer=0;
	my @alpha=("a".."z","A".."Z"," ", <? ! . : >)[*;*];
	my @alpha1=@alpha;
	my @alpha2=@alpha;
	for $*IN.lines {
		put join "", .comb.map: { chaochiper(@alpha1,@alpha2, $_, :$decode) };
	};
}	

sub chaochiper(@alpha1,@alpha2,  $c, :$decode=False){
	my $p=($decode??@alpha2!!@alpha1).grep($c,:k)[0];
	my $ct=($decode??@alpha1!!@alpha2)[$p];	

	given @alpha1 {
		.=rotate($p+1);
		.splice(.elems div 2, 0, .splice(2,1));
	}
	given @alpha2 {
		.=rotate($p);
		.splice(.elems div 2, 0, .splice(1,1));
	}
	$ct;
}
