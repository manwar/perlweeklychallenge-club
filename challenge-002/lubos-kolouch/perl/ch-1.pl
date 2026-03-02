#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 2;

=head1 NAME

remove_leading_zeros - removes leading zeros from positive numbers

=head1 SYNOPSIS

    use remove_leading_zeros;
    my $num = "0001234";
    my $result = remove_leading_zeros($num);
    print "$result\n"; # "1234"

=head1 DESCRIPTION

This module exports one function, remove_leading_zeros, which takes a string
containing a positive number with leading zeros and returns the number with
leading zeros removed.

=head1 FUNCTIONS

=head2 remove_leading_zeros

    my $result = remove_leading_zeros($num);

Removes leading zeros from the positive number in $num and returns the result.

=cut

sub remove_leading_zeros {
    my $num = shift;
    $num =~ s/^0+//;
    return length($num) ? $num : '0';
}

# Test remove_leading_zeros function
is(remove_leading_zeros("0001234"), "1234", "Leading zeros removed from number");
is(remove_leading_zeros("000"), "0", "All zeros collapse to 0");

done_testing();
