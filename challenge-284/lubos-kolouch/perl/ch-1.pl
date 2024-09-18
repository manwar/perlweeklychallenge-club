#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 3;

=pod

=head1 DESCRIPTION

This script finds the lucky integer in a given array of integers.

A lucky integer is defined as an integer whose frequency in the array is equal to its value.

If there are multiple lucky integers, the largest one is returned. If no lucky integers are found, -1 is returned.

=head1 FUNCTIONS

=head2 find_lucky_integer(\@ints)

Given an array reference of integers, returns the lucky integer as per the problem definition.

=over 4

=item * C<\@ints> - Reference to an array of integers.

=back

Returns the lucky integer if found, otherwise -1.

=cut

sub find_lucky_integer {
    my ($ints_ref) = @_;
    my %freq;

    foreach my $num (@$ints_ref) {
        $freq{$num}++;
    }

    my @lucky_integers;
    foreach my $num (keys %freq) {
        if ($num == $freq{$num}) {
            push @lucky_integers, $num;
        }
    }

    if (@lucky_integers) {
        return (sort { $b <=> $a } @lucky_integers)[0];
    } else {
        return -1;
    }
}

# Unit Tests
is(find_lucky_integer([2, 2, 3, 4]), 2, 'Example 1');
is(find_lucky_integer([1, 2, 2, 3, 3, 3]), 3, 'Example 2');
is(find_lucky_integer([1, 1, 1, 3]), -1, 'Example 3');

done_testing();
