#!/usr/bin/perl
use warnings;
use strict;

sub largest_multiple {
    my @digits = @_;
    my (@odd, @even);
    push @{ $_ % 2 ? \@odd : \@even }, $_ for @digits;
    die "No multiple of 2 possible" unless @even;

    my @last = (8, 0);
    for (0 .. $#even) {
        @last = ($even[$_], $_) if $even[$_] < $last[0];
    }

    splice @even, $last[1], 1;
    my $number = join "", sort { $b <=> $a } @odd, @even;
    $number .= $last[0];
    $number =~ s/^00+/0/ and warn 'Starting zeros removed';
    return $number
}

use Test::More;
use Test::Exception;
use Test::Warnings ':all';

is largest_multiple(1, 0, 2, 6), 6210, 'Example 1';
is largest_multiple(1, 4, 2, 8), 8412, 'Example 2';
is largest_multiple(4, 1, 7, 6), 7614, 'Example 3';

is largest_multiple(0 .. 9), 9876543210, 'All digits';

is largest_multiple(0), 0, 'Zero';

like warning { is largest_multiple(0, 0), 0, 'Zeros' },
     qr/Starting zeros removed/, 'Warns';

throws_ok { largest_multiple(1, 3, 5) }
          qr/No multiple of 2 possible/, 'Exception';

done_testing(9);
