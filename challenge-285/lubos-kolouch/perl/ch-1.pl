#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Str);
use Test::More;

=pod

=head1 NAME

ch-1.pl - No Connection (The Weekly Challenge 285 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl "B,C" "D,B" "C,A"
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

This script finds the destination city with no further outgoing connection
from a given list of routes.

=head1 FUNCTIONS

=head2 find_destination($routes)

Given an array reference of routes, where each route is an array reference
containing a source and a destination city, returns the city that is a
destination but not a source in any route, or C<undef> if no such city exists.

=over 4

=item * C<$routes> - Reference to an array of routes (array references of source and destination cities).

=back

Returns the destination city with no outgoing connections.

=cut

signature_for find_destination => (
    method     => 0,
    positional => [ ArrayRef [ ArrayRef [Str] ] ],
);

sub find_destination ($routes_ref) {
    my %sources;
    my %destinations;

    for my $route (@$routes_ref) {
        my ( $source, $destination ) = @$route;
        $sources{$source}           = 1;
        $destinations{$destination} = 1;
    }

    for my $city ( sort keys %destinations ) {
        if ( !exists $sources{$city} ) {
            return $city;
        }
    }

    return;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @routes = map { [ split /,/, $_, 2 ] } @args;
    my $dest   = find_destination( \@routes ) // 'None';
    say "Output: $dest";
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            routes   => [ [ 'B', 'C' ], [ 'D', 'B' ], [ 'C', 'A' ] ],
            expected => 'A',
        },
        {
            label    => 'Example 2',
            routes   => [ [ 'A', 'Z' ] ],
            expected => 'Z',
        },
        {
            label    => 'Cycle with no terminal destination',
            routes   => [ [ 'A', 'B' ], [ 'B', 'A' ] ],
            expected => undef,
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is( find_destination( $case->{routes} ), $case->{expected}, $case->{label} );
    }
    done_testing();
}

_run_cli(@ARGV);

=cut
