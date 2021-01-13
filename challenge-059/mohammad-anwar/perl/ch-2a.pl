#!/usr/bin/perl

use Test::More;

use Algorithm::Combinatorics qw(combinations);

my $unit_tests = [
    { in => [1, 2, 3], out => 4 },
    { in => [2, 3, 4], out => 6 },
];

foreach my $unit_test (@$unit_tests) {
    is (&s($unit_test->{in}), $unit_test->{out});
}

done_testing;

sub s {
    my ($A) = @_;

    my $sum = 0;
    foreach my $pair (combinations($A, 2)) {
        $sum += f(@$pair);
    }

    return $sum;
}

sub f {
    my ($a, $b) = @_;

    $a = sprintf("%b", $a);
    $b = sprintf("%b", $b);

    my $m = length($a) > length($b) ? length($a) : length($b);
    my $f = '%0'.$m.'d';
    my @a = split //, sprintf $f, $a;
    my @b = split //, sprintf $f, $b;

    my $bits = 0;
    foreach (0..$m-1) {
        $bits += 1 if ($a[$_] != $b[$_]);
    }

    return $bits;
}
