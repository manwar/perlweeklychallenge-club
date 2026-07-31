#!/usr/bin/env perl
#
=head1

Task 2: Special Binary Substrings

Submitted by: Mohammad Sajid Anwar

You are given a binary string.  Write a script to return all non-empty
substrings (distinct) that have the same number of 0's and 1's, and all the 0's
and all the 1's in these substrings are grouped consecutively.

=head2 Example 1

    Input: $binary = "0101"
    Output: ("01", "10")

=head2 Example 2

    Input: $binary = "000111"
    Output: ("000111", "0011", "01")

=head2 Example 3

    Input: $binary = "000011"
    Output:  ("0011", "01")

=head2 Example 4

    Input: $binary = "10011100"
    Output: ("10", "0011", "01", "1100")

=head2 Example 5

    Input: $binary = "00000"
    Output: ()

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {binary => "0101",     out => ["01", "10"],                 name => "Example 1"},
    {binary => "000111",   out => ["000111", "0011", "01"],     name => "Example 2"},
    {binary => "000011",   out => ["0011", "01"],               name => "Example 3"},
    {binary => "10011100", out => ["0011", "01", "10", "1100"], name => "Example 4"},
    {binary => "00000",    out => [],                           name => "Example 5"},
);

sub special_binary_substrings
{
    my $binary = shift;
    my %seen;

    for my $i (0 .. length($binary) - 1) {
        for my $j ($i + 2 .. length($binary)) {
            my $substr = substr($binary, $i, $j - $i);
            next if exists $seen{$substr};
            my $count_0 = $substr =~ tr/0//;
            my $count_1 = $substr =~ tr/1//;
            $seen{$substr} = true if $count_0 == $count_1 && $substr =~ /^(0+1+|1+0+)$/;
        }
    }
    return [sort keys %seen];
}

for my $case (@cases) {
    my $got = special_binary_substrings($case->{binary});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
