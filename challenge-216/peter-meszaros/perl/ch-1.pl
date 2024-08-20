#!/usr/bin/env perl
#
=head1 Task 1: Registration Number

Submitted by: Mohammad S Anwar

You are given a list of words and a random registration number.

Write a script to find all the words in the given list that has every letter in
the given registration number.

=head2 Example 1

	Input: @words = ('abc', 'abcd', 'bcd'), $reg = 'AB1 2CD'
	Output: ('abcd')

	The only word that matches every alphabets in the given registration number is 'abcd'.

=head2 Example 2

	Input: @words = ('job', 'james', 'bjorg'), $reg = '007 JB'
	Output: ('job', 'bjorg')

=head2 Example 3

	Input: @words = ('crack', 'road', 'rac'), $reg = 'C7 RA2'
	Output: ('crack', 'rac')

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/none/;

my $cases = [
	[[['abc',   'abcd',  'bcd'],   'AB1 2CD'], ['abcd'],         'Example 1'],
	[[['job',   'james', 'bjorg'], '007 JB'],  ['job', 'bjorg'], 'Example 2'],
	[[['crack', 'road',  'rac'],   'C7 RA2'],  ['crack', 'rac'], 'Example 3'],
];

sub registration_number
{
	my $words = $_[0]->[0];
	my $reg   = $_[0]->[1];

    my @reg = grep { /[a-z]/ } split('', lc $reg);

    my $ret;
	for my $w (@$words) {
		my %l = map { $_, 1 } split '', $w;
		my @r = @l{@reg};
        if (none { not defined } @r) {
			push @$ret, $w;
		}
	}
	return $ret;
}

for (@$cases) {
    is(registration_number($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
