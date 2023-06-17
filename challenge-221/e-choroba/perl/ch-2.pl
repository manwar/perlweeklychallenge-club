#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub arithmetic_subsequence(@ints) {
    goto &arithmetic_subsequence_naive if @ints <= 200;
    goto &arithmetic_subsequence_optimised
}

sub arithmetic_subsequence_naive(@ints) {
    my $max = -1;
    for my $first (0 .. $#ints - 1) {
        for my $second ($first + 1 .. $#ints) {
            my $length = 2;
            my $step = $ints[$second] - $ints[$first];
            my $last = $ints[$second];
            for my $k ($second + 1 .. $#ints) {
                if ($ints[$k] == $last + $step) {
                    $last = $ints[$k];
                    ++$length;
                }
            }
            $max = $length if $length > $max;
        }
    }
    return $max
}

sub arithmetic_subsequence_optimised(@ints) {
    my $max = -1;
    my %tried;
    for my $first (0 .. $#ints - 1) {
        for my $second ($first + 1 .. $#ints) {
            my $length = 2;
            my $step = $ints[$second] - $ints[$first];
            next if exists $tried{$first}{$step};

            undef $tried{$first}{$step};
            next if exists $tried{$second}{$step};

            undef $tried{$second}{$step};
            my $last = $ints[$second];

            for my $k ($second + 1 .. $#ints) {
                if ($ints[$k] == $last + $step) {
                    ++$length;
                    $last = $ints[$k];
                    undef $tried{$k}{$step};
                }
            }
            $max = $length if $length > $max;
        }
    }
    return $max
}

use Test::More tests => 3 + 1;

is arithmetic_subsequence(9, 4, 7, 2, 10), 3, 'Example 1';
is arithmetic_subsequence(3, 6, 9, 12), 4, 'Example 2';
is arithmetic_subsequence(20, 1, 15, 3, 10, 5, 8), 4, 'Example 3';

use Benchmark qw{ cmpthese };

my @l = map int rand 100, 1 .. 200;
is arithmetic_subsequence_naive(@l),
    arithmetic_subsequence_optimised(@l),
    'same';

cmpthese(-3, {
    short_naive => sub { arithmetic_subsequence_naive(@l[0..10]) },
    short_opt   => sub { arithmetic_subsequence_optimised(@l[0..10]) },
});
cmpthese(-3, {
    long_naive => sub { arithmetic_subsequence_naive(@l) },
    long_opt   => sub { arithmetic_subsequence_optimised(@l) },
});

__END__
               Rate   short_opt short_naive
short_opt   12948/s          --        -49%
short_naive 25447/s         97%          --
             Rate long_naive   long_opt
long_naive 11.2/s         --       -42%
long_opt   19.5/s        74%         --
