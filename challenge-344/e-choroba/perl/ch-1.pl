#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub array_form_compute($x, @ints) {
    my $y = join "", @ints;
    return split //, $x + $y
}

sub array_form_compute_array($x, @ints) {
    splice @ints, 0, 0, (0) x (length($x) - @ints) if @ints < length $x;
    my @x = split //, $x;
    splice @x, 0, 0, (0) x (@ints - @x) if @x < @ints;
    for my $i (1 .. @x) {
        $ints[ -$i ] += $x[ -$i ];
        if ($i != @x && $ints[ -$i ] > 9) {
            $ints[ -$i ] -= 10;
            ++$ints[ -$i - 1 ];
        }
    }
    if ($ints[0] > 9) {
        $ints[0] -= 10;
        unshift @ints, 1;
    }
    return @ints
}

use Test2::V0;
plan(5 * 2 + 100);

for my $array_form_compute (\&array_form_compute, \&array_form_compute_array) {
    is [$array_form_compute->(12, 1, 2, 3, 4)], [1, 2, 4, 6], 'Example 1';
    is [$array_form_compute->(181, 2, 7, 4)], [4, 5, 5], 'Example 2';
    is [$array_form_compute->(1, 9, 9, 9)], [1, 0, 0, 0], 'Example 3';
    is [$array_form_compute->(9999, 1, 0, 0, 0, 0)], [1, 9, 9, 9, 9],
        'Example 4';
    is [$array_form_compute->(1000, 0)], [1, 0, 0, 0], 'Example 5';
}

for (1 .. 100) {
    my $x = int rand 10000;
    my @ints = split //, int rand 10000;
    warn "$x @ints";
    is array_form_compute($x, @ints), array_form_compute_array($x, @ints),
        "Same $x @ints";
}

use Benchmark qw{ cmpthese };
my $x = int rand 100_000;
my @ints = split //, int rand 100_000;
cmpthese(-3, {
    plus => sub { array_form_compute($x, @ints) },
    arr  => sub { array_form_compute_array($x, @ints) }
});

__END__

         Rate  arr plus
arr  434213/s   -- -56%
plus 985269/s 127%   --
