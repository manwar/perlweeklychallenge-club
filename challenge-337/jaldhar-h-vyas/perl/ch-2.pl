#!/usr/bin/perl
use v5.38;
use warnings;
use builtin qw/ indexed /;
no warnings qw/ experimental::builtin experimental::for_list /;

sub count(@matrix) {
    my $count = 0;

    for my $row (@matrix) {
        $count += scalar grep { $_ % 2 } @{$row};
    }

    return $count;
}

my ($row, $col, @locations) = @ARGV;

my @matrix;
for my $i (0 .. $row - 1) {
    push @matrix, [ (0) x $col ];
}

for my $location (@locations) {
    my ($r, $c) = split /,/, $location;
    for (@{$matrix[$r]}[0 .. $col - 1]) {
        $_++;
    }
    for (@matrix[0 .. $row - 1]->[$c]) {
        $_++;
    }
}

say count(@matrix);
