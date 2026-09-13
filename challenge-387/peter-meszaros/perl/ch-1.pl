#!/usr/bin/env perl
#
=head1 Task 1: Rearrange Binary String

Submitted by: Mohammad Sajid Anwar

You are given a binary string string.  Write a script to re-arrange the given
binary string that all occurrences of "01" are simultaneously replaced with
"10" until no occurrences of "01" exist. Finally return the total steps needed.

=head2 Example 1

    Input: $str = "111000"
    Output: 0

    The string already has all 1s on the left and 0s on the right.
    There are no occurrences of "01", so zero step needed.

=head2 Example 2

    Input: $str = "00011"
    Output: 4

    Step 1: "00101"
    Step 2: "01010"
    Step 3: "10100"
    Step 4: "11000"

=head2 Example 3

    Input: $str = "01011"
    Output: 3

    Step 1: "10101"
    Step 2: "11010"
    Step 3: "11100"

=head2 Example 4

    Input: $str = "010101"
    Output: 3

    Step 1: "101010"
    Step 2: "110100"
    Step 3: "111000"

=head2 Example 5

    Input: $str = "00001"
    Output: 4

    Step 1: "00010"
    Step 2: "00100"
    Step 3: "01000"
    Step 4: "10000"

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {str => "111000", out => 0, name => 'Example 1'},
    {str => "00011",  out => 4, name => 'Example 2'},
    {str => "01011",  out => 3, name => 'Example 3'},
    {str => "010101", out => 3, name => 'Example 4'},
    {str => "00001",  out => 4, name => 'Example 5'},
);

sub rearrange_binary_string
{
    my $str = shift;

    my $step = 0;
    for my $step (1 .. length($str)) {
        my $new_str = $str;
        $new_str =~ s/01/10/g;
        return $step - 1 if $new_str eq $str;
        $str = $new_str;
        ++$step;
    }
    return undef;
}

for my $case (@cases) {
    my $got = rearrange_binary_string($case->{str});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
