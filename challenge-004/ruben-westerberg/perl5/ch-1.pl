#!/usr/bin/env perl
use Math::BigRat;
my $places= (stat $0)[7];
printf "Places: $places\n";
my $prev="";
my $sign;
my $pi=Math::BigRat->new("0/1");
my $denom=1;
print "Pi start\n";
my $stable= 0;
my $i=0;
my $float;
until ($stable) {
	$sign= (($i % 2) ? -4  : 4);
	$pi->badd("$sign/$denom");
	$denom+=2;
	$i++;
	$float=$pi->as_float($places);
	printf "Iteration: $i, Value of PI (to $places decimal places):$float\n";
	$stable="$float" eq "$prev";
	$prev=$float;
}
