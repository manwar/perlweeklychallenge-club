#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

# Using https://oeis.org/A143901.
sub odd_sum(@ints) {
    my $sum = 0;
    for my $m (1 .. @ints) {
        my $n = @ints - $m + 1;
        my $r = int(($m * $n + 1) / 2);
        $sum += $r * $ints[$m - 1]
    }
    return $sum
}

sub odd_sum_naive(@ints) {
    my $sum = 0;
    for my $from (0 .. $#ints) {
        for my $length (1 .. $#ints - $from + 1) {
            next if 0 == $length % 2;

            $sum += $_ for @ints[$from .. $from + $length - 1];
        }
    }
    return $sum
}

use Test::More tests => (2 + 1) * 2;

my %DISPATCH = (odd_sum => \&odd_sum,
                odd_sum_naive => \&odd_sum_naive);

my @long = sort grep ! /77/, 1 .. 500;
for my $odd_sum (qw( odd_sum odd_sum_naive )) {
    is $DISPATCH{$odd_sum}(2, 5, 3, 6, 4), 77, "Example 1 $odd_sum";
    is $DISPATCH{$odd_sum}(1, 3), 4, "Example 2 $odd_sum";

    is $DISPATCH{$odd_sum}(@long), 2856088560, "Long list $odd_sum";
}

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    naive => sub { odd_sum_naive(@long) },
    fast  => sub { odd_sum(@long) },
});

__END__
        Rate   naive    fast
naive 2.45/s      --   -100%
fast  7200/s 293300%      --
