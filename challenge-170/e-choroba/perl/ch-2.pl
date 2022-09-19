#!/usr/bin/perl
use warnings;
use strict;

use PDL;
use PDL::NiceSlice;
sub kronecker_product {
    my ($x, $y) = @_;
    my ($x0, $x1) = $x->dims;
    my ($y0, $y1) = $y->dims;

    return (
        $y * $x->dummy(0, $y0)->dummy(1, $y1)
    )->xchg(1, 2)->reshape($x0 * $y0, $x1 * $y1)
}

sub kron_rosetta {
	my $A = shift;
	my $B = shift;
	my ($r0, $c0) = $A->dims;
	my ($r1, $c1) = $B->dims;
	my $kron = zeroes($r0 * $r1, $c0 * $c1);
	for(my $i = 0; $i < $r0; ++$i){
		for(my $j = 0; $j < $c0; ++$j){
			$kron(
				($i * $r1) : (($i + 1) * $r1 - 1),
				($j * $c1) : (($j + 1) * $c1 - 1)
			) .= $A($i,$j) * $B;
		}
	}
	return $kron;
}

use Test::More tests => 4;

my $A = pdl([1, 2], [3, 4]);
my $B = pdl([5, 6], [7, 8]);
my $AB = pdl([ 5,  6, 10, 12],
             [ 7,  8, 14, 16],
             [15, 18, 20, 24],
             [21, 24, 28, 32]);

is_deeply kronecker_product($A, $B), $AB;
is_deeply kron_rosetta($A, $B), $AB;

my $X = pdl([1, -4, 7], [-2, 3, 3]);
my $Y = pdl([8, -9, -6,  5],
            [1, -3, -4,  7],
            [2,  8, -8, -3],
            [1,  2, -5, -1]);
my $XY =pdl([8, -9, -6, 5, -32, 36, 24, -20, 56, -63, -42, 35],
            [1, -3, -4, 7, -4, 12, 16, -28, 7, -21, -28, 49],
            [2, 8, -8, -3, -8, -32, 32, 12, 14, 56, -56, -21],
            [1, 2, -5, -1, -4, -8, 20, 4, 7, 14, -35, -7],
            [-16, 18, 12, -10, 24, -27, -18, 15, 24, -27, -18, 15],
            [-2, 6, 8, -14, 3, -9, -12, 21, 3, -9, -12, 21],
            [-4, -16, 16, 6, 6, 24, -24, -9, 6, 24, -24, -9],
            [-2, -4, 10, 2, 3, 6, -15, -3, 3, 6, -15, -3]);

is_deeply kronecker_product($X, $Y), $XY;
is_deeply kron_rosetta($X, $Y), $XY;

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    choroba => sub { kronecker_product($X, $Y) },
    rosetta => sub { kron_rosetta($X, $Y) }
});

__END__
           Rate rosetta choroba
rosetta  9509/s      --    -63%
choroba 25377/s    167%      --
