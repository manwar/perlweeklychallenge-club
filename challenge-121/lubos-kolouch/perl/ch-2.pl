#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-2.pl - The Travelling Salesman

=head1 SYNOPSIS

  perl ch-2.pl        # runs the embedded tests
  perl ch-2.pl run    # prints the example result

=head1 DESCRIPTION

Given an NxN matrix of distances between N cities, find a minimum-length round
trip starting at city 0, visiting each city exactly once, and returning to 0.

This implementation uses brute-force permutations, which is suitable for small
N (as in the challenge example).

=cut

sub tsp_min_tour ($matrix) {
    my $n = scalar @$matrix;
    die "Expected square matrix\n" if $n == 0;
    for my $row (@$matrix) {
        die "Expected square matrix\n" if scalar(@$row) != $n;
    }

    return { length => 0, tour => [0] } if $n == 1;

    my @cities = ( 1 .. $n - 1 );
    my $best_len;
    my @best_tour;

    my $recurse;
    $recurse = sub ( $idx, $prefix, $used ) {
        if ( $idx == @cities ) {
            my @tour = ( 0, @$prefix, 0 );
            my $len  = 0;
            for my $i ( 0 .. $#tour - 1 ) {
                $len += $matrix->[ $tour[$i] ][ $tour[ $i + 1 ] ];
            }
            if ( !defined($best_len) || $len < $best_len ) {
                $best_len  = $len;
                @best_tour = @tour;
            }
            return;
        }

        for my $c (@cities) {
            next if $used->{$c};
            $used->{$c} = 1;
            push @$prefix, $c;
            $recurse->( $idx + 1, $prefix, $used );
            pop @$prefix;
            delete $used->{$c};
        }
    };

    $recurse->( 0, [], {} );
    return { length => $best_len, tour => \@best_tour };
}

sub _example_matrix () {
    return [
        [ 0, 5, 2, 7 ],
        [ 5, 0, 5, 3 ],
        [ 3, 1, 0, 6 ],
        [ 4, 5, 4, 0 ],
    ];
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my $res = tsp_min_tour( _example_matrix() );
    Test::More::plan( tests => 2 );
    Test::More::is( $res->{length}, 10, 'Example length' );
    Test::More::is_deeply( $res->{tour}, [ 0, 2, 1, 3, 0 ], 'Example tour' );
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 run\n" if @args != 1 || $args[0] ne 'run';

    my $res = tsp_min_tour( _example_matrix() );
    say "length = $res->{length}";
    say 'tour = (' . join( ' ', @{ $res->{tour} } ) . ')';
}

_run_cli(@ARGV);

