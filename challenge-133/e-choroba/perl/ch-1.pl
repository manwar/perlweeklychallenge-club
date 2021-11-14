#!/usr/bin/perl
use warnings;
use strict;

sub naive_isqr {
    my ($n) = @_;
    my $i = 0;
    1 while ++$i ** 2 <= $n;
    return $i - 1
}

sub newton_isqr {
    my ($n) = @_;
    my $x0 = $n >> 1;
    return $n unless $x0;

    my $x1 = ( $x0 + $n / $x0 ) >> 1;
    while ($x1 < $x0) {
        $x0 = $x1;
        $x1 = ($x0 + $n / $x0 ) >> 1;
    }
    return $x0
}

use Test2::V0;
plan 13;

is newton_isqr(10), 3, 'Example 1';
is newton_isqr(27), 5, 'Example 2';
is newton_isqr(85), 9, 'Example 3';
is newton_isqr(101), 10, 'Example 4';

is newton_isqr(25), 5, 'Exact';
is newton_isqr(24), 4, 'One below';

for my $n (10, 27, 85, 101, 25, 24, 123456) {
    is naive_isqr($n), newton_isqr($n), "Same $n";
}

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    naive  => sub {  naive_isqr(123456) },
    newton => sub { newton_isqr(123456) },
});

=begin Benchmark

           Rate  naive newton
naive   82453/s     --   -92%
newton 998832/s  1111%     --

=end Benchmark

=cut
