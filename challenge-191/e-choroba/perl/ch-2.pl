#! /usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use Memoize;

memoize('_cute_list', NORMALIZER => sub { "$_[0] @{ $_[1] }" });
sub cute_list ($n) {
    _cute_list(1, [1 .. $n]);
}

sub are_divisible ($m, $n) { 0 == $m % $n || 0 == $n % $m }

sub _cute_list ($pos, $list) {
    return are_divisible($pos, $list->[0]) ? 1 : 0 if 1 == @$list;

    my $sum = 0;
    for my $i (0 .. $#$list) {
        $sum += _cute_list($pos + 1, [@$list[grep $_ != $i, 0 .. $#$list]])
            if are_divisible($pos, $list->[$i]);
    }
    return $sum
}

use Test::More tests => 1 + 14;
is cute_list(2), 2, 'Example 1';

is cute_list(1), 1, 'Size 1';
is cute_list(3), 3, 'Size 3';
is cute_list(4), 8, 'Size 4';
is cute_list(5), 10, 'Size 5';
is cute_list(6), 36, 'Size 6';
is cute_list(7), 41, 'Size 7';
is cute_list(8), 132, 'Size 8';
is cute_list(9), 250, 'Size 9';
is cute_list(10), 700, 'Size 10';
is cute_list(11), 750, 'Size 11';
is cute_list(12), 4010, 'Size 12';
is cute_list(13), 4237, 'Size 13';
is cute_list(14), 10680, 'Size 14';
is cute_list(15), 24679, 'Max';
