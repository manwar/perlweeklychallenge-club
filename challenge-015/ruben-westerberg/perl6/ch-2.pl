#!/usr/bin/env perl6

sub MAIN ( Str $key, Bool :$decode, Str :$file ) {	
	my $f=$decode??1!!-1;
	$*OUT.out-buffer=0;
	my @alpha=("a".."z","A".."Z"," ", <? ! . : >)[*;*];
	my @a=@alpha.keys;
	my @k=$key.comb.map(-> $c {|@alpha.grep($c,:k)});
	for $*IN.lines -> $line {
		my @in= $line.comb.map(->$c {|@alpha.grep($c,:k)});
		my @t= (@in >>+>> (@k >>*>> $f)) >>%>> @a.elems;
		put  join "", @alpha[@t];
	}
}	
