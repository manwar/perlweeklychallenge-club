#!/usr/bin/env perl
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

=head1 NAME

ch-1.pl - Hamiltonian Cycle

=head1 DESCRIPTION

You are given a target number.
Write a script to arrange all the whole numbers from 1 up to the given target number into a circle so that every pair of side-by-side numbers adds up to a perfect square. Please make sure, the last number and the first must also add up to a square.

=cut

sub hamiltonian_cycle ($n) {
    return [] if $n < 1;
    if ($n == 1) {
        return [];
    }

    # Precompute squares up to 2n
    my %squares;
    for (my $i = 1; $i * $i <= 2 * $n; $i++) {
        $squares{$i * $i} = 1;
    }

    # Build adjacency list
    my %adj;
    for my $u (1 .. $n) {
        for my $v (1 .. $n) {
            next if $u == $v;
            if ($squares{$u + $v}) {
                push @{$adj{$u}}, $v;
            }
        }
    }

    my @path = (1);
    my %visited = (1 => 1);

    if (_dfs($n, 1, \%adj, \%squares, \@path, \%visited)) {
        return \@path;
    }
    return [];
}

sub _dfs ($n, $u, $adj, $squares, $path, $visited) {
    if (scalar @$path == $n) {
        # Check if the last and first elements add up to a perfect square
        if ($squares->{$path->[-1] + 1}) {
            return 1;
        }
        return 0;
    }

    return 0 unless exists $adj->{$u};

    for my $v (@{$adj->{$u}}) {
        next if $visited->{$v};

        $visited->{$v} = 1;
        push @$path, $v;

        if (_dfs($n, $v, $adj, $squares, $path, $visited)) {
            return 1;
        }

        pop @$path;
        delete $visited->{$v};
    }

    return 0;
}

sub _run_cli (@args) {
    if (!@args) { _run_tests(); return; }
    die "Usage: perl $0\n(Run with no arguments to execute the unit tests)\n";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    # Test n = 32
    my $res32 = hamiltonian_cycle(32);
    Test::More::is(scalar @$res32, 32, "n=32 returns a cycle of length 32");
    if (scalar @$res32 == 32) {
        # Verify the sum of adjacent elements are perfect squares
        my $ok = 1;
        my %squares = map { $_ * $_ => 1 } (1 .. 10);
        for my $i (0 .. 31) {
            my $sum = $res32->[$i] + $res32->[($i + 1) % 32];
            $ok = 0 unless $squares{$sum};
        }
        Test::More::ok($ok, "Adjacent elements in n=32 sum to perfect squares");
    }

    # Test n = 15 (should be impossible)
    my $res15 = hamiltonian_cycle(15);
    Test::More::is(scalar @$res15, 0, "n=15 has no solution");

    Test::More::done_testing();
}

_run_cli(@ARGV);
