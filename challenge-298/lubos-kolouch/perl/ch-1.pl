#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use List::Util      qw(min max);
use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int);

=pod

=head1 NAME

ch-1.pl - Maximal Square

=head1 SYNOPSIS

  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Find the area of the largest square sub-matrix containing only 1s.

Uses dynamic programming:

  dp[r][c] = 1 + min(dp[r-1][c], dp[r][c-1], dp[r-1][c-1]) if matrix[r][c] == 1

The answer is (max dp)^2.

=cut

my $MATRIX_CHECK = compile( ArrayRef [ArrayRef [Int]] );

sub maximal_square_area ($matrix) {
    ($matrix) = $MATRIX_CHECK->($matrix);
    return 0 if !@$matrix;

    my $rows = scalar @$matrix;
    my $cols = scalar @{ $matrix->[0] };
    die 'Non-rectangular matrix' if grep { @$_ != $cols } @$matrix;

    my @dp = map { [ (0) x $cols ] } 1 .. $rows;
    my $best = 0;

    for my $r ( 0 .. $rows - 1 ) {
        for my $c ( 0 .. $cols - 1 ) {
            my $val = $matrix->[$r][$c];
            die 'Matrix must contain only 0 and 1' if $val != 0 && $val != 1;
            next if $val == 0;

            my $size;
            if ( $r == 0 || $c == 0 ) {
                $size = 1;
            }
            else {
                $size = 1 + min( $dp[ $r - 1 ][$c], $dp[$r][ $c - 1 ], $dp[ $r - 1 ][ $c - 1 ] );
            }
            $dp[$r][$c] = $size;
            $best        = $size if $size > $best;
        }
    }

    return $best * $best;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "CLI not implemented; run without args for tests\n";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        {
            label  => 'Example 1',
            matrix => [
                [ 1, 0, 1, 0, 0 ],
                [ 1, 0, 1, 1, 1 ],
                [ 1, 1, 1, 1, 1 ],
                [ 1, 0, 0, 1, 0 ],
            ],
            expected => 4,
        },
        { label => 'Example 2', matrix => [ [ 0, 1 ], [ 1, 0 ] ], expected => 1 },
        { label => 'Example 3', matrix => [ [0] ],               expected => 0 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( maximal_square_area( $case->{matrix} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 maximal_square_area($matrix)

Returns the area (side^2) of the largest all-1s square in the matrix.

=cut
