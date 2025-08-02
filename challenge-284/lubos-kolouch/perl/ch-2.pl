#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 3;

=pod

=head1 DESCRIPTION

This script sorts the elements of @list1 based on the relative order defined in @list2. Elements in @list1 that are not in @list2 are placed at the end in ascending order.

=head1 FUNCTIONS

=head2 relative_sort(\@list1, \@list2)

Sorts @list1 based on the order of elements in @list2.

=over 4

=item * C<\@list1> - Reference to the first list of integers.

=item * C<\@list2> - Reference to the second list of integers defining the relative order.

=back

Returns a sorted array.

=cut

sub relative_sort {
    my ($list1_ref, $list2_ref) = @_;
    my %order;
    my @result;

    # Assign order to elements in @list2
    my $idx = 0;
    foreach my $num (@$list2_ref) {
        $order{$num} = $idx++;
    }

    # Separate elements that are in @list2 and not in @list2
    my @in_list2;
    my @not_in_list2;

    foreach my $num (@$list1_ref) {
        if (exists $order{$num}) {
            push @in_list2, $num;
        } else {
            push @not_in_list2, $num;
        }
    }

    # Sort elements in @list1 that are in @list2 based on the order in @list2
    @in_list2 = sort {
        $order{$a} <=> $order{$b}
            ||
        $a <=> $b  # To handle duplicates
    } @in_list2;

    # Sort elements not in @list2 in ascending order
    @not_in_list2 = sort { $a <=> $b } @not_in_list2;

    # Combine the two lists
    @result = (@in_list2, @not_in_list2);

    return @result;
}

# Unit Tests
is_deeply(
    [relative_sort([2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5], [2, 1, 4, 3, 5, 6])],
    [2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9],
    'Example 1'
);

is_deeply(
    [relative_sort([3, 3, 4, 6, 2, 4, 2, 1, 3], [1, 3, 2])],
    [1, 3, 3, 3, 2, 2, 4, 4, 6],
    'Example 2'
);

is_deeply(
    [relative_sort([3, 0, 5, 0, 2, 1, 4, 1, 1], [1, 0, 3, 2])],
    [1, 1, 1, 0, 0, 3, 2, 4, 5],
    'Example 3'
);

done_testing();
