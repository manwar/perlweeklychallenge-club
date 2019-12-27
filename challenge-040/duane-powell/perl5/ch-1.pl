#!/usr/bin/perl
use warnings;
use strict;
use feature qw( say );

my $AoA = [
	[qw( I L O V E Y O U !)],
	[qw( 2 4 0 3 2 0 1 9)],
	[qw( ! ? $ $ % ^ & * @ + -)],
];

my $max = 0;
foreach my $aref ( @{$AoA} ) {
	$max = (scalar(@{$aref}) > $max) ? scalar(@{$aref}) : $max;
}

foreach my $i (0 .. $max-1) {
	my $out;
	foreach my $aref ( @{$AoA} ) {
		$out .= defined($aref->[$i]) ? $aref->[$i] : " ";
	}
	say $out;
}

__END__

./ch-1.pl
I2!
L4?
O0$
V3$
E2%
Y0^
O1&
U9*
! @
  +
  -
