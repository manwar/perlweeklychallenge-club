#!/usr/bin/env perl6
my $path=@*ARGS[0]//($?FILE.IO.dirname~"/../words_alpha.txt");
my $states=any ($?FILE.IO.dirname~"/../states.txt").IO.lines>>.lc;
my $longest="";
($path.IO.lines>>.lc)
.grep( *.chars %% 2).map({
	my $p= .comb().map(*~*).all;
	$longest =  $_ if  (grep $p, $states) && $_.chars > $longest.chars;
;});
put $longest;
	
