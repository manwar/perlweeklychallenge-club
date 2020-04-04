#!/usr/bin/perl
use strict;
use integer;


sub knot {
	if ($_[0]) {$_[0] = 0;} else {$_[0] = 1};
	return $_[0];
}

if ($ARGV[0] == undef or $ARGV[1] == undef) {die "not enough arguments";}

my $P = $ARGV[0];
my $k = $ARGV[1];

my @result = ();

my @char = 1..$P;


my @arrow = map { 1 } @char; #arrows for algorithm for generating permututations
#true for pointing to left, undef for pointing to right

my $n = 1;

my @mobile = ();    #store the indices

sub mmax {  #modified from "Learning Perl", return the index of the largest char which in the status of  mobile
	my @mchar = @char;
	my $champion = shift @_;
	foreach (@_) {
		if ( $mchar[$_] gt $mchar[$champion]) {$champion = $_;}
	}
	$champion;
}


my $noofperm = 1;
for my $i (1..$P) {$noofperm *= $i;}

push @result, join("", @char);

while ( $n <= $noofperm-1  ) {	
	my $j;
	@mobile = ();
	$j = 0; if ( ($char[$j] gt $char[$j+1]) and not($arrow[$j])) {
		push @mobile, $j;
	}
	for $j (1..$#char-1) {
		if ( ( $char[$j] gt $char[$j-1] and $arrow[$j]) or 
		( $char[$j] gt $char[$j+1] and not($arrow[$j])) ) {
			push @mobile, $j; 
		}
	}
	$j = $#char; if ( $char[$j] gt $char[$j-1] and $arrow[$j]) {
		push @mobile, $j;
	}


	if ( $#mobile >= 0 ) {
		my $m = &mmax(@mobile); 
		my $todaychamp;   # a character
		my $arrowdirection; # a boolean
		if (not($arrow[$m])) { 
			$todaychamp = $char[$m]; 
			$char[$m]=$char[$m+1]; 
			$char[$m+1] = $todaychamp;
			$arrowdirection = $arrow[$m];
			$arrow[$m] = $arrow[$m+1];
			$arrow[$m+1] = $arrowdirection;
	# then switch the direction of all the arrows above integers p with p>m
			foreach (0..$#char) {
				if ($char[$_] gt $todaychamp ) {
					$arrow[$_] = &knot($arrow[$_]); 
				}
			}
		} else {
			$todaychamp = $char[$m]; 
			$char[$m]=$char[$m-1]; 
			$char[$m-1] = $todaychamp;
			$arrowdirection = $arrow[$m];
			$arrow[$m] = $arrow[$m-1];
			$arrow[$m-1] = $arrowdirection;
			foreach (0..$#char) {
				if ($char[$_] gt $todaychamp  ) {
					$arrow[$_] = &knot($arrow[$_]); 
				}
			}
		}
	}
	#switch the largest mobile integer m and the adjacent integer its arrow points to; the algorithms used here ref to "Introductory Combinatorics" 4th Edition by page 88, by Richard A. Brualdi  
	push @result, join("", @char);
	$n++;

}

my @fresult = sort {$a <=> $b} @result;

print $result[$k-1];

# Thanks for my worn combinatorics textbook again.
