#!/usr/bin/env perl
#
=head1 Task 1: Reverse String

Submitted by: Mohammad Sajid Anwar

You are given a string.  Write a script to reverse the given string without
using standard reverse function.

=head2 Example 1

    Input: $str = ""
    Output: ""

=head2 Example 2

    Input: $str = "reverse the given string"
    Output: "gnirts nevig eht esrever"

=head2 Example 3

    Input: $str = "Perl is Awesome"
    Output: "emosewA si lreP"

=head2 Example 4

    Input: $str = "v1.0.0-Beta!"
    Output: "!ateB-0.0.1v"

=head2 Example 5

    Input: $str = "racecar"
    Output: "racecar"

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {str => "",                         expected => "",                         label => "Example 1"},
    {str => "reverse the given string", expected => "gnirts nevig eht esrever", label => "Example 2"},
    {str => "Perl is Awesome",          expected => "emosewA si lreP",          label => "Example 3"},
    {str => "v1.0.0-Beta!",             expected => "!ateB-0.0.1v",             label => "Example 4"},
    {str => "racecar",                  expected => "racecar",                  label => "Example 5"},
);

sub reverse_string
{
    my $str = shift;
    
    my $reversed = '';
    for (my $i = length($str) - 1; $i >= 0; $i--) {
        $reversed .= substr($str, $i, 1);
    }
    
    return $reversed;
}

plan(tests => scalar @cases);
for my $case (@cases) {
    my $got = reverse_string($case->{str});
    is($got, $case->{expected}, $case->{label});
}
done_testing();

exit 0;
