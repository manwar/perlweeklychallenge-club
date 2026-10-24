#!/usr/bin/perl
use strict;
use warnings;

# This week's challenge is a filtering task. A hash lookup seems to me the
# best solution: it is efficient for both small and large datasets.

# I've made the challenge a little more complete by adding validation checks,
# rather than assuming that the input is always valid. These checks are not
# strictly necessary, but they make the solution more robust and provide an
# opportunity to explore some additional Perl techniques.

sub validate_positive_integers {

    my ($array) = @_;

    # \A and \z match the absolute beginning and end of the string.
    die "Invalid input: positive integers required\n"
        if grep { !defined($_) || !/\A[1-9]\d*\z/ } @$array;

}

sub validate_friends {

    my ($f) = @_;

    # The friends' list must not be empty.
    die "Invalid friends\n" unless @$f;

    # All numbers must be positive integers.
    validate_positive_integers($f);

    # The friends' numbers must be strictly increasing.
    die "Invalid friends\n"
        if grep { $f->[$_] >= $f->[$_ + 1] } 0 .. $#$f - 1;

}

sub validate_order {

    my ($o) = @_;

    # All numbers must be positive integers.
    validate_positive_integers($o);

    # Create a hash containing every number in the order.
    my %order = map { $_ => 1 } @$o;

    # Count the participants in the finishing order.
    my $n = @$o;

    # The order must contain no duplicates, and every
    # number from 1 to $n must occur.
    die "Invalid order\n"
        if keys(%order) != $n
        || grep { !exists $order{$_} } 1 .. $n;

}

sub finishing_order {

    my ($o, $f) = @_;

    # Validate the input.
    validate_friends($f);
    validate_order($o);

    # Create a hash containing the numbers of all friends.
    my %f = map { $_ => 1 } @$f;

    # Keep only the friends, preserving the finishing order.
    my @common = grep { exists $f{$_} } @$o;

    # Return the finishing positions of the friends.
    return @common;
}

# Tests

my @order;
my @friends;

# Example 1
@order = (3, 1, 4, 2, 5);
@friends = (1, 2, 4);
print "Result: (" . join(", ", finishing_order(\@order, \@friends)) . ")\n"; # Output: (1, 4, 2)

# Example 2
@order = (5, 4, 3, 2, 1);
@friends = (1, 3, 5);
print "Result: (" . join(", ", finishing_order(\@order, \@friends)) . ")\n"; # Output: (5, 3, 1)

# Example 3
@order = (2, 4, 1, 3);
@friends = (1, 2, 3, 4);
print "Result: (" . join(", ", finishing_order(\@order, \@friends)) . ")\n"; # Output: (2, 4, 1, 3)

# Example 4
@order = (4, 1, 3, 2);
@friends = (3);
print "Result: (" . join(", ", finishing_order(\@order, \@friends)) . ")\n"; # Output: (3)

# Example 5
@order = (1, 3, 2, 6, 5, 4);
@friends = (1, 2, 3);
print "Result: (" . join(", ", finishing_order(\@order, \@friends)) . ")\n"; # Output: (1, 3, 2)
