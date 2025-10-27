#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures state);
no warnings qw(experimental::signatures);
use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 PURPOSE

Simulate the “last visitor” queue defined in the challenge. Positive
integers arriving from left to right are stored with the newest at the front,
and each C<-1> requests the visitor seen C<x> places earlier in that queue,
where C<x> counts consecutive C<-1> values encountered so far.

=head1 ALGORITHM

The input array is validated as an array reference of integers. We iterate
through the values maintaining two arrays:

=over 4

=item *
C<@seen> keeps previously encountered positive integers with the newest at
the front.

=item *
C<@ans> collects the values to return for each C<-1>.

=back

Whenever we see a C<-1>, we look up the C<x>-th element in C<@seen> counting
from zero (if present) and append that value to C<@ans>; otherwise we append
C<-1>. Runs of C<-1> values are tracked so the lookup offset increments
within the run, and resets when a positive integer appears.

=cut

## no critic (Subroutines::ProhibitSubroutinePrototypes)
sub last_visitor ($ints_ref) {
    state $check = compile( ArrayRef [Int] );
    my ($ints) = $check->($ints_ref);

    my @seen;
    my @answer;
    my $neg_run = 0;

    for my $value (@$ints) {
        if ( $value == -1 ) {
            my $lookup = $neg_run < @seen ? $seen[$neg_run] : -1;
            push @answer, $lookup;
            $neg_run++;
            next;
        }

        unshift @seen, $value;
        $neg_run = 0;
    }

    return \@answer;
}

# Example tests provided by the specification.
is_deeply( last_visitor( [ 5, -1, -1 ] ),              [ 5, -1 ], 'Example 1' );
is_deeply( last_visitor( [ 3, 7, -1, -1, -1 ] ),       [ 7,  3,  -1 ], 'Example 2' );
is_deeply( last_visitor( [ 2, -1, 4, -1, -1 ] ),       [ 2,  4,  2 ],  'Example 3' );
is_deeply( last_visitor( [ 10, 20, -1, 30, -1, -1 ] ), [ 20, 30, 20 ], 'Example 4' );
is_deeply( last_visitor( [ -1, -1, 5, -1 ] ),          [ -1, -1, 5 ],  'Example 5' );

done_testing();
