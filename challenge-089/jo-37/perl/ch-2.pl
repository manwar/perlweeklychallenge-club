#!/usr/bin/perl

use 5.012;
use PDL;
use Test2::V0 '!float';

# Siamese method to construct an odd order magic square.
# See https://en.wikipedia.org/wiki/Siamese_method
$::verbose = 0;
sub siamese {
	my $n = shift;
	my $ord =  2 * $n + 1 ;
	my $msq = zeroes(long, $ord, $ord)->inplace->setvaltobad(0);
	my $idx = long $n, 0;
	for my $val (1 .. $ord ** 2) {
		$msq->range($idx, 0, 'periodic') .= $val;
		say $msq if $::verbose;
		$idx += $val % $ord ? long(1, -1) : long(0, 1);
	}
	# Return order, magic constant and magic square
	($ord, ($ord**3 + $ord) / 2, $msq);
}

# Create some magic squares and check row, column and diagonal
# sums.
for my $n (1 .. 3) {
	my ($ord, $magic, $sq) = siamese $n;
	say $sq;

	is $sq->sumover->unpdl, [($magic) x $ord], 'row sums';
	is $sq->xchg(0, 1)->sumover->unpdl, [($magic) x $ord], 'col sums';
	is sum($sq->diagonal(0, 1)), $magic, 'diag sum';
	is sum($sq->slice('-1:0')->diagonal(0, 1)), $magic, 'antidiag sum';
}

done_testing;
