#!/usr/bin/env perl
#
=head1 Task 1: Percentage of Character

You are given a string, $str and a character $char.

Write a script to return the percentage, nearest whole, of given character in
the given string.

=head2 Example 1

	Input: $str = "perl", $char = "e"
	Output: 25

=head2 Example 2

	Input: $str = "java", $char = "a"
	Output: 50

=head2 Example 3

	Input: $str = "python", $char = "m"
	Output: 0

=head2 Example 4

	Input: $str = "ada", $char = "a"
	Output: 67

=head2 Example 5

	Input: $str = "ballerina", $char = "l"
	Output: 22

=head2 Example 6

	Input: $str = "analitik", $char = "k"
	Output: 13

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[['perl',      'e'], 25],
	[['java',      'a'], 50],
	[['python',    'm'],  0],
	[['ada',       'a'], 67],
	[['ballerina', 'l'], 22],
	[['analitik',  'k'], 13],
];

sub percentage_of_character
{
	my $str = $_[0]->[0];
	my $chr = $_[0]->[1];

	my $num = () = $str =~ /$chr/gi; 
	return int($num / length($str) * 100.0 + 0.5);
}

for (@$cases) {
    is(percentage_of_character($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
