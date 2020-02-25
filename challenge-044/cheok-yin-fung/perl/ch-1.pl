#!/usr/bin/perl -w
use strict;
use integer;

my @digits = 1..9;

sub expression {
}


my @poweroft = (6561,2187, 729, 243, 81, 27, 9, 3, 1);
for my $i (1..6560) {

	my @ooo = (0,0,0,0,0,0,0,0);    # 0 -> conjuction , 1 -> plus , 2 -> minus 
	for my $j (0..7) {
		$ooo[$j] = int($i % $poweroft[$j]) / int($poweroft[$j+1]) ;
	}
	

	my @objects = (1,0,0,0,0,0,0,0,0); 
	my $objectindex = 0;
	for my $j (0..7) {
		if ($ooo[$j] == 0) {
			$objects[$objectindex] = $objects[$objectindex]*10 + $digits[$j+1];
		} else {$objectindex++; $objects[$objectindex] = $digits[$j+1];}
	}

	my $result = $objects[0];
	$objectindex = 0;

	for my $j (0..7) { 
		if ($ooo[$j] == 1) {$objectindex++; $result += $objects[$objectindex]; }
		if ($ooo[$j] == 2) {$objectindex++; $result -= $objects[$objectindex]; }
	}
	


	if ($result == 100) {


		print $digits[0]; 
		for my $j (0..7) {
			if ($ooo[$j]==1 ) {print "+"; }
			if ($ooo[$j]==2 ) {print "-"; }
			print $digits[$j+1];
		} 
		print "\n";
	}
}
		
