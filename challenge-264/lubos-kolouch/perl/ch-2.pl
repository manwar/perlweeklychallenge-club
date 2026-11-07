#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-2.pl - Target Array (The Weekly Challenge 264 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl
  # runs the embedded tests

=head1 DESCRIPTION

You are given two arrays of integers, C<@source> and C<@indices>.
The C<@indices> can only contain integers C<0 <= i < size of @source>.

Write a script to create a target array by inserting at index C<$indices[$i]>
the value C<$source[$i]>.

=head1 FUNCTIONS

=head2 create_target_array($source, $indices)

Builds the target array by inserting elements from C<$source> at positions given by C<$indices>.

=over 4

=item * C<$source> - Reference to an array of source integers.

=item * C<$indices> - Reference to an array of insertion indices.

=back

Returns an array reference representing the resulting target array.

=cut

signature_for create_target_array => (
    method     => 0,
    positional => [ ArrayRef [Int], ArrayRef [Int] ],
);

sub create_target_array ( $source, $indices ) {
    my @target;

    for my $i ( 0 .. $#$source ) {
        splice( @target, $indices->[$i], 0, $source->[$i] );
    }

    return \@target;
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            source   => [ 0, 1, 2, 3, 4 ],
            indices  => [ 0, 1, 2, 2, 1 ],
            expected => [ 0, 4, 1, 3, 2 ],
        },
        {
            label    => 'Example 2',
            source   => [ 1, 2, 3, 4, 0 ],
            indices  => [ 0, 1, 2, 3, 0 ],
            expected => [ 0, 1, 2, 3, 4 ],
        },
        {
            label    => 'Example 3',
            source   => [1],
            indices  => [0],
            expected => [1],
        },
        {
            label    => 'Empty arrays',
            source   => [],
            indices  => [],
            expected => [],
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is_deeply(
            create_target_array( $case->{source}, $case->{indices} ),
            $case->{expected},
            $case->{label}
        );
    }
}

_run_tests();

=cut
