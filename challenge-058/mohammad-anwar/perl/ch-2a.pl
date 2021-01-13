#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Deep;

my $unit_tests = [
    { in  => { H => [2, 6, 4, 5, 1, 3],
               T => [1, 0, 2, 0, 1, 2],
             },
      out => [5, 1, 2, 6, 3, 4],
    },
];

foreach my $unit_test (@$unit_tests) {
    is_deeply(order_lineup($unit_test->{in}), $unit_test->{out});
}

done_testing;

sub order_lineup {
    my ($args) = @_;

    my @H = @{$args->{H}};
    my @T = @{$args->{T}};
    my $O = [];

    my $H_T = { map { $H[$_] => $T[$_] } 0 .. scalar(@H)-1 };
    foreach my $h (sort { $b <=> $a } keys %$H_T) {

        my $i = 0;
        my $j = 0;

        while ($H_T->{$h} > $j) {
            $j++ if ($O->[$i] > $h);
            $i++;
        }

        splice @$O, $i, 0, $h;
    }

    return $O;
}
