#!/usr/bin/env perl6
my $maxLength=@*ARGS[0]//20; #If no max on command line use 20
while 1 {
	my $str="";
	#make a random length string of upto $maxLength long
	$str~=(1.rand()+40).round.chr for 0..$maxLength.rand.Int;
	my @v= [\+] $str.comb.map({(ord($_)-40)*-2+1});

	if @v[*-1]==0 and !@v.grep(* < 0) {
		put "balanced: $str";
		sleep 1;
		next;
	}
	say "unbalanced: $str";
}


