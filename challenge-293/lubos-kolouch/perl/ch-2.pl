#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int);

=pod

=head1 NAME

ch-2.pl - Boomerang (WWC 293 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of three points in a 2D plane: [[x1, y1], [x2, y2], [x3, y3]].
A boomerang is a set of three points that are all distinct and not in a straight line.
Write a script to return 'true' if the given points form a boomerang, 'false' otherwise.

=cut

my $POINTS_CHECK = compile( ArrayRef [ ArrayRef [Int] ] );

sub is_boomerang ($points) {
    ($points) = $POINTS_CHECK->($points);
    die 'Exactly three points are required' if @$points != 3;

    for my $p (@$points) {
        die 'Each point must have 2 coordinates' if @$p != 2;
    }

    my ( $x1, $y1 ) = @{ $points->[0] };
    my ( $x2, $y2 ) = @{ $points->[1] };
    my ( $x3, $y3 ) = @{ $points->[2] };

    # Check distinctness
    my %point_set;
    $point_set{"$x1,$y1"}++;
    $point_set{"$x2,$y2"}++;
    $point_set{"$x3,$y3"}++;

    return 'false' if scalar keys %point_set < 3;

    # Cross-product determinant: (x2 - x1)*(y3 - y1) - (y2 - y1)*(x3 - x1)
    my $cross_product = ( $x2 - $x1 ) * ( $y3 - $y1 ) - ( $y2 - $y1 ) * ( $x3 - $x1 );

    return $cross_product != 0 ? 'true' : 'false';
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
        { label => 'Example 1', points => [ [ 1, 1 ], [ 2, 3 ], [ 3, 2 ] ], expected => 'true' },
        { label => 'Example 2', points => [ [ 1, 1 ], [ 2, 2 ], [ 3, 3 ] ], expected => 'false' },
        { label => 'Example 3', points => [ [ 1, 1 ], [ 1, 2 ], [ 2, 3 ] ], expected => 'true' },
        { label => 'Example 4', points => [ [ 1, 1 ], [ 1, 2 ], [ 1, 3 ] ], expected => 'false' },
        { label => 'Example 5', points => [ [ 1, 1 ], [ 2, 1 ], [ 3, 1 ] ], expected => 'false' },
        { label => 'Example 6', points => [ [ 0, 0 ], [ 2, 3 ], [ 4, 5 ] ], expected => 'true' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        Test::More::is( is_boomerang( $case->{points} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=pod

=head1 FUNCTIONS

=head2 is_boomerang(\@points)

Returns 'true' if the three points form a boomerang (distinct and non-collinear), 'false' otherwise.

=cut
