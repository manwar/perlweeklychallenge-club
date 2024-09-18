#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 2;

=pod

=head1 DESCRIPTION

This script finds the destination with no further outgoing connection from a given list of routes.

=head1 FUNCTIONS

=head2 find_destination(\@routes)

Given an array reference of routes, where each route is an array reference containing a source and a destination city, this function returns the city that is a destination but not a source in any route.

=over 4

=item * C<\@routes> - Reference to an array of routes (array references of source and destination cities).

=back

Returns the destination city with no outgoing connections.

=cut

sub find_destination {
    my ($routes_ref) = @_;
    my %sources;
    my %destinations;

    foreach my $route (@$routes_ref) {
        my ($source, $destination) = @$route;
        $sources{$source} = 1;
        $destinations{$destination} = 1;
    }

    foreach my $city (keys %destinations) {
        unless (exists $sources{$city}) {
            return $city;
        }
    }
    return undef;  # In case there is no such city
}

# Unit Tests
is(find_destination([["B","C"], ["D","B"], ["C","A"]]), "A", 'Example 1');
is(find_destination([["A","Z"]]), "Z", 'Example 2');

done_testing();
