#!/usr/bin/perl
use strict;
use warnings;

=begin
Just straightforward coding, easily following the task description.
=cut

sub relative_sort {

    # retrieve the first list from the reference
    my @list1 = @{ shift() };
    # retrieve the second list from the reference
    my @list2 = @{ shift() };

    # create a hash map for the positions of elements in @list2
    my %element_order_list2 = map { $list2[$_] => $_ } 0 .. $#list2;

    # separate @list1 elements into those in @list2 and those not in @list2
    my (@in_list2, @not_in_list2);
    foreach ( @list1 ) {
        ( exists $element_order_list2{$_} ) ? push(@in_list2, $_)
                                            : push(@not_in_list2, $_);
    }

    # sort @in_list2 according to the order in @list2
    @in_list2 = sort { $element_order_list2{$a} <=> $element_order_list2{$b} } @in_list2;

    # sort @not_in_list2 in ascending order
    @not_in_list2 = sort { $a <=> $b } @not_in_list2;

    # combine both lists
    return(@in_list2, @not_in_list2);
}

# Tests

my (@list1, @list2);

# Example 1
@list1 = (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5);
@list2 = (2, 1, 4, 3, 5, 6);
print("(", join(", ", relative_sort(\@list1, \@list2)), ")\n"); # Output: (2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9)

# Example 2
@list1 = (3, 3, 4, 6, 2, 4, 2, 1, 3);
@list2 = (1, 3, 2);
print("(", join(", ", relative_sort(\@list1, \@list2)), ")\n"); # Output: (1, 3, 3, 3, 2, 2, 4, 4, 6)

# Example 3
@list1 = (3, 0, 5, 0, 2, 1, 4, 1, 1);
@list2 = (1, 0, 3, 2);
print("(", join(", ", relative_sort(\@list1, \@list2)), ")\n"); # Output: (1, 1, 1, 0, 0, 3, 2, 4, 5)
