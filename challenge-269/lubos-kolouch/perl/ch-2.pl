#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-2.pl - Distribute Elements (The Weekly Challenge 269 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl 2 1 3 4 5
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of 2 or more distinct integers, C<@ints>.

Write a script to distribute the elements into two arrays as follows:
1) Move the 1st element of C<@ints> to a new array C<@arr1>.
2) Move the 2nd element of C<@ints> to a new array C<@arr2>.
3) Repeatedly move the next element of C<@ints> to C<@arr1> or C<@arr2>, depending on:
   a) If the last element of C<@arr1> is greater than the last element of C<@arr2>,
      move the next element to C<@arr1>.
   b) Otherwise, move the next element to C<@arr2>.
4) Once C<@ints> is empty, return the concatenated arrays C<(@arr1, @arr2)>.

=head1 FUNCTIONS

=head2 distribute_elements($ints)

Distributes elements into two arrays following the described rule and returns
the concatenated result as an array reference.

=over 4

=item * C<$ints> - Reference to an array of 2 or more distinct integers.

=back

Returns an array reference containing the concatenated distributed elements.

=cut

signature_for distribute_elements => (
    method     => 0,
    positional => [ ArrayRef [Int] ],
);

sub distribute_elements ($ints) {
    my @remaining = @$ints;
    return []           if @remaining == 0;
    return [@remaining] if @remaining == 1;

    my @arr1 = ( shift @remaining );
    my @arr2 = ( shift @remaining );

    for my $elem (@remaining) {
        if ( $arr1[-1] > $arr2[-1] ) {
            push @arr1, $elem;
        }
        else {
            push @arr2, $elem;
        }
    }

    return [ @arr1, @arr2 ];
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { int($_) } @args;
    my $res  = distribute_elements( \@ints );
    say join( ', ', @$res );
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            ints     => [ 2, 1, 3, 4, 5 ],
            expected => [ 2, 3, 4, 5, 1 ],
        },
        {
            label    => 'Example 2',
            ints     => [ 3, 2, 4 ],
            expected => [ 3, 4, 2 ],
        },
        {
            label    => 'Example 3',
            ints     => [ 5, 4, 3, 8 ],
            expected => [ 5, 3, 4, 8 ],
        },
        {
            label    => 'Two elements',
            ints     => [ 10, 20 ],
            expected => [ 10, 20 ],
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is_deeply( distribute_elements( $case->{ints} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=cut
