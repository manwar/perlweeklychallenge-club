#!/usr/bin/env perl6

my $bigPi=FatRat.new(31415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679,10**100);

sub factorial($n) {
	constant @f= (1.FatRat, |[\*] 1.FatRat..*);
	@f[$n];
}
sub taylor-e ($atVal) {

	my $sum=0.FatRat;
	my $x=$atVal.FatRat;
	for 0..200 {
		 $sum+=($x**$_)/factorial($_);
		 say "Iteration $_: " ~ $sum.Str.substr(0,50);
	}
	$sum;
}

sub newton-sqrt($val, $target, $repeat){
	my $guess=$val.FatRat;
	for ^$repeat {
		$guess:=($guess - ($guess**2 -$target)/(2*$guess));
	}
	$guess;
}
say taylor-e($bigPi*newton-sqrt(10,163,6)).Str.substr(0,50);
