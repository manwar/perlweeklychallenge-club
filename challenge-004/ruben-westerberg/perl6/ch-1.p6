#!/usr/bin/env perl6
my $places= $*PROGRAM-NAME.IO.s + 1;
printf "Places: $places\n";
my $prev="";
my $sign;
my $pi=(0/1).FatRat;
my $denom=1;
my $stable= 0;
my $i=0;
my $float;
until ($stable) {
	$sign= (($i %% 2) ?? 4  !! -4);
	$pi+=($sign/$denom).FatRat;
	$denom+=2;
	$i++;
	$float=$pi.Str.substr(0,$places+1);
	say "Iteration: $i, Value of PI (to $places decimal places):$float";
	$stable=$float eq $prev;
	$prev=$float;
}
