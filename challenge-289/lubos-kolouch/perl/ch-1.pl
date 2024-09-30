#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 3;

=pod

=head1 DESCRIPTION

This script finds the third distinct maximum number in a given array of integers.
If the third maximum doesn't exist, it returns the maximum number.

=head1 FUNCTIONS

=head2 third_distinct_maximum(\@ints)

Given an array reference of integers, returns the third distinct maximum number.
If it doesn't exist, returns the maximum number.

=over 4

=item * C<\@ints> - Reference to an array of integers.

=back

Returns the third distinct maximum if it exists, otherwise the maximum number.

=cut

sub third_distinct_maximum {
    my ($ints_ref) = @_;
    my %seen;
    my @distinct_descending = sort { $b <=> $a } grep { !$seen{$_}++ } @$ints_ref;

    if (@distinct_descending >= 3) {
        return $distinct_descending[2];
    } else {
        return $distinct_descending[0];
    }
}

# Unit Tests
is(third_distinct_maximum([5, 6, 4, 1]), 4, 'Example 1');
is(third_distinct_maximum([4, 5]), 5, 'Example 2');
is(third_distinct_maximum([1, 2, 2, 3]), 1, 'Example 3');

done_testing();
