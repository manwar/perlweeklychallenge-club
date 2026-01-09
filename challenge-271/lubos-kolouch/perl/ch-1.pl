#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use JSON::PP;
use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int);

=pod

=head1 NAME

ch-1.pl - Maximum Ones

=head1 SYNOPSIS

  perl ch-1.pl '[[0,1],[1,0]]'
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

Given an m x n binary matrix, return the 1-based row number containing the
maximum number of ones; if there is a tie, return the smallest row number.

=cut

my $MATRIX_CHECK = compile( ArrayRef [ ArrayRef [Int] ] );

sub maximum_ones ($matrix) {
    ($matrix) = $MATRIX_CHECK->($matrix);
    die 'Expected a non-empty matrix' if @$matrix == 0;

    my $best_row   = 1;
    my $best_count = -1;
    for my $i ( 0 .. $#$matrix ) {
        my $count = 0;
        $count += $_ for @{ $matrix->[$i] };
        if ( $count > $best_count ) {
            $best_count = $count;
            $best_row   = $i + 1;
        }
    }
    return $best_row;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    die "Usage: perl $0 '<json-matrix>'\n" if @args != 1;
    my $json   = $args[0];
    my $matrix = JSON::PP->new->decode($json);
    my $out    = maximum_ones($matrix);
    say "Output: $out";
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    my @cases = (
        { label => 'Example 1', matrix => [ [ 0, 1 ], [ 1, 0 ] ],             expected => 1 },
        { label => 'Example 2', matrix => [ [ 0, 0, 0 ], [ 1, 0, 1 ] ],       expected => 2 },
        { label => 'Example 3', matrix => [ [ 0, 0 ], [ 1, 1 ], [ 0, 0 ] ],   expected => 2 },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( maximum_ones( $case->{matrix} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 maximum_ones($matrix)

Returns the 1-based index of the row with the maximum number of ones.

=cut

