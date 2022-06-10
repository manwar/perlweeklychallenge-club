#!/usr/bin/raku

my %saveprimes=();
my ($p1,$p2,$p3)=(3,0,2);
for ^Inf {
	my $chk=$p1;
	my $p4=$p1+$p2;
	$p1=$p2; $p2=$p3;$p3=$p4;
	(is-prime($chk)) && (%saveprimes{$chk}=1);
	%saveprimes.elems==13 && last;
}

say %saveprimes.keys.sort({.Int});



