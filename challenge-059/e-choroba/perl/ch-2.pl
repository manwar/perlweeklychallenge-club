#!/usr/bin/perl
use warnings;
use strict;

sub diff_bits {
    my ($x, $y) = @_;
    return unpack '%32b*', pack 'N', $x ^ $y
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

sub chain_diff_bits2 {
    my (@list) = @_;
    my @binary = map { unpack 'b*', pack N => $_ } @list;
    my $s = 0;
    for my $pos (0 .. length($binary[0]) - 1) {
        my $ones = grep $_, map { substr $_, $pos, 1 } @binary;
        $s += $ones * (@list - $ones);
    }
    return $s
}

sub chain_diff_bits3 {
    my (@list) = @_;
    my $s = 0;
    my $mask = 1;
    for (1 .. 8 * length $list[0]) {
        my $ones = grep $mask & $_, @list;
        $mask <<= 1;
        $s += $ones * (@list - $ones);
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

is chain_diff_bits2(2, 3, 4), 6, 'chain 2 3 4';
is chain_diff_bits2(89, 106, 116), 12, 'chain 89, 106, 116';

is chain_diff_bits3(2, 3, 4), 6, 'chain 2 3 4';
is chain_diff_bits3(89, 106, 116), 12, 'chain 89, 106, 116';

=heading1 Last test explained

   89 | 1 1 1 0 1 0 0
  106 | 1 1 0 1 0 1 0
  116 | 1 0 1 1 0 0 1
   ---+--------------
        0+2+2+2+2+2+2 = 12

=cut

my @l = map int rand 100, 1 .. 1000;

is  chain_diff_bits(@l),
    chain_diff_bits2(@l), 'same 1 2';
is  chain_diff_bits2(@l),
    chain_diff_bits3(@l), 'same 2 3';

done_testing();

use Benchmark qw{ cmpthese };
cmpthese(-2, {
    new => sub { chain_diff_bits2(@l) },
    old => sub { chain_diff_bits(@l) },
    newest => sub { chain_diff_bits3(@l) }
});
