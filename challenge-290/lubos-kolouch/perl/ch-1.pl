#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 3;

=pod

=head1 DESCRIPTION

This script checks if there exist two indices $i and $j in an array of integers such that:

1) $i != $j

2) 0 <= ($i, $j) < scalar @ints

3) $ints[$i] == 2 * $ints[$j]

=head1 FUNCTIONS

=head2 double_exist(\@ints)

Given an array reference of integers, returns 'true' if such indices exist, 'false' otherwise.

=over 4

=item * C<\@ints> - Reference to an array of integers.

=back

Returns 'true' or 'false'.

=cut

sub double_exist {
    my ($ints_ref) = @_;
    my %seen;
    foreach my $num (@$ints_ref) {
        # Check for zero separately to avoid division by zero
        if ($num == 0) {
            return 'true' if $seen{0};
        } else {
            return 'true' if exists $seen{$num * 2} || ($num % 2 == 0 && exists $seen{$num / 2});
        }
        $seen{$num} = 1;
    }
    return 'false';
}

# Unit Tests
is(double_exist([6, 2, 3, 3]), 'true', 'Example 1');
is(double_exist([3, 1, 4, 13]), 'false', 'Example 2');
is(double_exist([2, 1, 4, 2]), 'true', 'Example 3');

done_testing();
