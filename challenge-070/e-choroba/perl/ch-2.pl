#! /usr/bin/perl
use warnings;
use strict;

sub greycode_recursive {
    my ($size) = @_;
    return [0, 1] if 1 == $size;

    my $seq = greycode_recursive($size - 1);
    my $highbit = 1 << $size - 1;
    my @revhi = map { $highbit | $_ } reverse @$seq;
    return [ @$seq, @revhi ]
}

sub greycode_iterative {
    my ($size) = @_;
    my @seq = map $_ ^ ($_ >> 1), 0 .. (1 << $size) - 1;
    return \@seq
}

use Test::More;
is_deeply greycode_recursive(3),
    [0, 1, 3, 2, 6, 7, 5, 4];
is_deeply greycode_recursive(4),
    [0, 1, 3, 2, 6, 7, 5, 4, 12, 13, 15, 14, 10, 11, 9, 8];

is_deeply greycode_recursive($_), greycode_iterative($_)
    for 1 .. 10;

done_testing();

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    recursive => 'greycode_recursive(10)',
    iterative => 'greycode_iterative(10)',
});
#             Rate recursive iterative
# recursive 3536/s        --      -10%
# iterative 3913/s       11%        --
