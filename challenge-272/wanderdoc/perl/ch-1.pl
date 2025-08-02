#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a valid IPv4 address.

Write a script to return the defranged version of the given IP address.

    A defranged IP address replaces every period "." with "[.]".

Example 1

Input: $ip = "1.1.1.1"
Output: "1[.]1[.]1[.]1"

Example 2

Input: $ip = "255.101.1.0"
Output: "255[.]101[.]1[.]0"
=cut

use Test2::V0;

is(defranged_IP("1.1.1.1"), "1[.]1[.]1[.]1", 'Example 1');
is(defranged_IP("255.101.1.0"), "255[.]101[.]1[.]0", 'Example 2');
done_testing();

sub defranged_IP
{
     my $str = $_[0];
     $str =~ s/\./[.]/g;
     return $str;
}