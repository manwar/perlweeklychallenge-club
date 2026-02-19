#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-2.pl - Ordered Lineup

=head1 SYNOPSIS

  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

Given arrays of unique heights C<@H> and, for each height, the number C<@T> of
taller people in front of that person, reconstruct one possible lineup.

Greedy approach:

- Sort people by height descending.
- Insert each person at index C<T> in the current lineup.

This works because, when processing from tallest to shortest, all already placed
people are taller.

=cut

sub ordered_lineup ( $heights, $taller_in_front ) {
    die "Mismatched input sizes\n" if @$heights != @$taller_in_front;

    my @people;
    for my $i ( 0 .. $#$heights ) {
        push @people, { h => $heights->[$i], t => $taller_in_front->[$i] };
    }

    @people = sort { $b->{h} <=> $a->{h} } @people;

    my @line;
    for my $p (@people) {
        my $idx = $p->{t};
        return undef if $idx < 0 || $idx > scalar(@line);
        splice @line, $idx, 0, $p->{h};
    }

    return \@line;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @H = ( 2, 6, 4, 5, 1, 3 );
    my @T = ( 1, 0, 2, 0, 1, 2 );
    Test::More::is_deeply(
        ordered_lineup( \@H, \@T ),
        [ 5, 1, 2, 6, 3, 4 ],
        'Small example'
    );

    my @H64 = (
        27, 21, 37,  4, 19, 52, 23, 64,  1,  7, 51, 17, 24, 50,  3,  2,
        34, 40, 47, 20,  8, 56, 14, 16, 42, 38, 62, 53, 31, 41, 55, 59,
        48, 12, 32, 61,  9, 60, 46, 26, 58, 25, 15, 36, 11, 44, 63, 28,
         5, 54, 10, 49, 57, 30, 29, 22, 35, 39, 45, 43, 18,  6, 13, 33
    );
    my @T64 = (
         6, 41,  1, 49, 38, 12,  1,  0, 58, 47,  4, 17, 26,  1, 61, 12,
        29,  3,  4, 11, 45,  1, 32,  5,  9, 19,  1,  4, 28, 12,  2,  2,
        13, 18, 19,  3,  4,  1, 10, 16,  4,  3, 29,  5, 49,  1,  1, 24,
         2,  1, 38,  7,  7, 14, 35, 25,  0,  5,  4, 19, 10, 13,  4, 12
    );
    my @A64 = (
        35, 23,  5, 64, 37,  9, 13, 25, 16, 44, 50, 40,  2, 27, 36,  6,
        18, 54, 20, 39, 56, 45, 12, 47, 17, 33, 55, 30, 26, 51, 42, 53,
        49, 41, 32, 15, 22, 60, 14, 46, 24, 59, 10, 28, 62, 38, 58, 63,
         8, 48,  4,  7, 31, 19, 61, 43, 57, 11,  1, 34, 21, 52, 29,  3
    );
    Test::More::is_deeply( ordered_lineup( \@H64, \@T64 ), \@A64, '64-person example' );

    Test::More::done_testing();
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Run without arguments to execute embedded tests.\n";
}

_run_cli(@ARGV);
