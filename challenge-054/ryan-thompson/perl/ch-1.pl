#!/usr/bin/env perl
#
# ch-1.pl - kth Permutation Sequence
#
# 2020 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
use Algorithm::Combinatorics qw<permutations>;

my ($n, $k) = @ARGV;
$n //= 3;
$k //= 4;

# Array version is compact
say join '', @{ ( permutations([1..$n], $n) )[$k-1] };

# Iterator version is usually slightly faster as it short-circuits
my $it = permutations([1..$n], $n);
$it->next for 1..$k-1;
say join '', @{ $it->next };

__END__
use Benchmark qw<cmpthese>;

cmpthese(-5, {
    array => sub { join '', @{ (permutations([1..$n], $n))[$k-1] } },
    iter  => sub {
        my $it = permutations([1..$n], $n);
        $it->next for 1..$k-1;
        join '', @{ $it->next };
    }
});
