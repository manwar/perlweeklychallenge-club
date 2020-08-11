#!/usr/bin/env perl6

my @vins:=@*ARGS;
my %keys=((0..9 Z 0..9),("A".."H" Z 1..8), ("J".."N" Z 1..5), "P",7, "R",9,("S".."Z" Z 2..9)).flat;
my @weights=((2..8).reverse,10,0,(2..9).reverse).flat;

for @vins {
	my $i=0;
	print "Testing $_: ";
	my $result="OK";	

	$result ="Invalid digits present" unless /^<[A..Z]+[0..9]>**17$/;
	$result ="Incorrect length" if $_.chars != 17;

	if $result eq "OK"  {
		my $check=$_.comb.map({%keys{$_} * @weights[$i++]}).sum % 11;
		$check="X" if $check == 10;
		$result= "Invalid VIN number" if $check ne $_.substr(8,1);
	}
	put $result;
}
