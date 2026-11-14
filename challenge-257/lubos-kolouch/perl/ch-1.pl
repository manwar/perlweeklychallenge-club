#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=head1 NAME

ch-1.pl - Smaller than Current

=head1 SYNOPSIS

    perl ch-1.pl

=head1 DESCRIPTION

Given an array of integers C<@ints>, find out how many integers are smaller
than each element, i.e., for each C<ints[i]>, count C<ints[j] < ints[i]>
where C<i != j>.

=head1 FUNCTIONS

=head2 smaller_than_current($ints)

Takes an ArrayRef of integers and returns an ArrayRef containing, for each
element, the count of elements in the array that are strictly smaller than it.

=cut

signature_for smaller_than_current => (
    method     => 0,
    positional => [ ArrayRef [Int] ],
);

sub smaller_than_current ($ints) {
    return [
        map {
            my $x = $_;
            scalar grep { $_ < $x } @$ints
        } @$ints
    ];
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            input    => [ 5, 2, 1, 6 ],
            expected => [ 2, 1, 0, 3 ],
        },
        {
            label    => 'Example 2',
            input    => [ 1, 2, 0, 3 ],
            expected => [ 1, 2, 0, 3 ],
        },
        {
            label    => 'Example 3',
            input    => [ 0, 1 ],
            expected => [ 0, 1 ],
        },
        {
            label    => 'Example 4',
            input    => [ 9, 4, 9, 2 ],
            expected => [ 2, 1, 2, 0 ],
        },
    );

    plan tests => scalar @cases;
    for my $case (@cases) {
        is_deeply(
            smaller_than_current( $case->{input} ),
            $case->{expected},
            $case->{label}
        );
    }
    return;
}

_run_tests() unless caller;
