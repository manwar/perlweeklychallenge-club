#!/usr/bin/perl
use warnings;
use strict;

sub diff_bits {
    my ($x, $y) = @_;
    my ($bx, $by) = map { pack 'N', $_ } $x, $y;
    return unpack '%32b*', $bx ^ $by
}

sub chain_diff_bits {
    my (@list) = @_;
    my $s = 0;
    for my $i (0 .. $#list - 1) {
        for my $j ($i + 1 .. $#list) {
            $s += diff_bits($list[$i], $list[$j]);
        }
    }
    return $s
}

use Test::More;

is diff_bits(0, 0), 0, 'd 0 0';
is diff_bits(0, 1), 1, 'd 0 1';
is diff_bits(0, 2), 1, 'd 0 2';
is diff_bits(0, 3), 2, 'd 0 3';
is diff_bits(0, 255), 8, 'd 0 255';
is diff_bits(255, 256), 9, 'd 255 256';
is diff_bits(113, 68), 4, 'd 113 68';

is chain_diff_bits(2, 3, 4), 6, 'chain 2 3 4';
is chain_diff_bits(89, 106, 116), 12, 'chain 89, 106, 116';

=heading1 Last test explained

   89 | 1 1 1 0 1 0 0
  106 | 1 1 0 1 0 1 0
  116 | 1 0 1 1 0 0 1
   ---+--------------
        0+2+2+2+2+2+2 = 12

=cut

done_testing();
