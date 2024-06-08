#!/usr/bin/env perl
#
=head1 Task 1: Defang IP Address

You are given a valid IPv4 address.

Write a script to return the defanged version of the given IP address.

    A defanged IP address replaces every period "." with "[.]".

=head2 Example 1

	Input: $ip = "1.1.1.1"
	Output: "1[.]1[.]1[.]1"

=head2 Example 2

	Input: $ip = "255.101.1.0"
	Output: "255[.]101[.]1[.]0"
=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	['1.1.1.1',     '1[.]1[.]1[.]1',     'Example 1'],
	['255.101.1.0', '255[.]101[.]1[.]0', 'Example 2'],
];

sub defang_ip_address
{
	my $ip = shift;
	$ip =~ s/\./\[\.\]/g;
	return $ip;
}

for (@$cases) {
    is(defang_ip_address($_->[0]), $_->[1], $_->[2]);
}

done_testing();

exit 0;
