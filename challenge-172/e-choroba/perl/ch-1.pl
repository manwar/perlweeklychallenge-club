#! /usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use Math::Prime::Util qw{ is_prime };

# Run faster.
use Memoize;
memoize '_prime_partition';

sub prime_partition ($sum, $size) {
    _prime_partition($sum, $size, 2)
}

sub _prime_partition ($sum, $size, $min) {
    if ($size == 2) {
        for my $p ($min .. $sum / 2) {
            next unless is_prime($p);

            return [$p, $sum - $p] if is_prime($sum - $p) && $sum != $p * 2;
        }
    } else {
        for my $p ($min .. $sum / $size) {
            next unless is_prime($p);

            my $rest = _prime_partition($sum - $p, $size - 1, $p + 1);
            return [$p, @$rest] if @$rest;
        }
    }
    return []
}

use Test::More tests => 5;

is_deeply prime_partition(18, 2), [5, 13], 'Example 1';
is_deeply prime_partition(19, 3), [3, 5, 11], 'Example 2';

is_deeply prime_partition(9, 3), [], 'No solution';
is_deeply prime_partition(4, 2), [], 'No duplicates';
is_deeply prime_partition(400, 12),
    [3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 43, 199], 'Long list';
