#/usr/bin/perl -w
use integer;
use strict;

sub min {
	if ($_[0] < $_[1]) {
		$_[0];
	} else {
		$_[1];
	}

}

my @t = (0, 0, 1);

for my $k (3..200) {
	if ($k % 2 == 0) {$t[$k] = 1+ &min( $t[$k/2] , $t[$k-1])}
		else {$t[$k] = $t[$k-1]+1;}
}

print $t[200], "\n";

