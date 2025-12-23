#!/usr/bin/env perl
#
=head1 Task 2: Validate Coupon

Submitted by: Mohammad Sajid Anwar

You are given three arrays, @codes, @names and @status.

Write a script to validate codes in the given array.

A code is valid when the following conditions are true:

    - codes[i] is non-empty and consists only of alphanumeric characters (a-z,
    A-Z, 0-9) and underscores (_).

    - names[i] is one of the following four categories: "electronics",
    "grocery", "pharmacy", "restaurant".

    - status[i] is true.

Return an array of booleans indicating validity: output[i] is true if and only
if codes[i], names[i] and status[i] are all valid.

=head2 Example 1

    Input: @codes  = ("A123", "B_456", "C789", "D@1", "E123")
           @names  = ("electronics", "restaurant", "electronics", "pharmacy", "grocery")
           @status = ("true", "false", "true", "true", "true")
    Output: (true, false, true, false, true)

=head2 Example 2

    Input: @codes  = ("Z_9", "AB_12", "G01", "X99", "test")
           @names  = ("pharmacy", "electronics", "grocery", "electronics", "unknown")
           @status = ("true", "true", "false", "true", "true")
    Output: (true, true, false, true, false)

=head2 Example 3

    Input: @codes  = ("_123", "123", "", "Coupon_A", "Alpha")
           @names  = ("restaurant", "electronics", "electronics", "pharmacy", "grocery")
           @status = ("true", "true", "false", "true", "true")
    Output: (true, true, false, true, true)

=head2 Example 4

    Input: @codes  = ("ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4")
           @names  = ("electronics", "electronics", "grocery", "grocery")
           @status = ("true", "true", "true", "true")
    Output: (true, true, true, true)

=head2 Example 5

    Input: @codes  = ("CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99")
           @names  = ("restaurant", "electronics", "grocery", "pharmacy", "electronics")
           @status = ("true", "true", "true", "true", "false")
    Output: (true, true, true, true, false)

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[["A123", "B_456", "C789", "D@1", "E123"],
      ["electronics", "restaurant", "electronics", "pharmacy", "grocery"],
      ["true", "false", "true", "true", "true"]],
     [true, false, true, false, true], "Example 1"],
    [[["Z_9", "AB_12", "G01", "X99", "test"],
      ["pharmacy", "electronics", "grocery", "electronics", "unknown"],
      ["true", "true", "false", "true", "true"]],
     [true, true, false, true, false], "Example 2"],
    [[["_123", "123", "", "Coupon_A", "Alpha"],
      ["restaurant", "electronics", "electronics", "pharmacy", "grocery"],
      ["true", "true", "false", "true", "true"]],
     [true, true, false, true, true], "Example 3"],
    [[["ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"],
      ["electronics", "electronics", "grocery", "grocery"],
      ["true", "true", "true", "true"]],
     [true, true, true, true], "Example 4"],
    [[["CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"],
      ["restaurant", "electronics", "grocery", "pharmacy", "electronics"],
      ["true", "true", "true", "true", "false"]],
     [true, true, true, true, false], "Example 5"],
];

sub validate_coupon
{
    my $codes  = $_[0]->[0];
    my $names  = $_[0]->[1];
    my $status = $_[0]->[2];

    my $valid_names = {
        electronics => 1,
        grocery     => 1,
        pharmacy    => 1,
        restaurant  => 1,
    };

    my @results;
    for my $i (0 .. $#$codes) {
        my $code = $codes->[$i];
        my $name = $names->[$i];
        my $stat = $status->[$i];

        push @results, ($code ne '' && $code =~ /^\w+$/) &&
                       (exists $valid_names->{$name}) &&
                       ($stat eq 'true');
    }
    return \@results;
}

for (@$cases) {
    is(validate_coupon($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
