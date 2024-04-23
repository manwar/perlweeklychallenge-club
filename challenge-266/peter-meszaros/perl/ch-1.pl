#!/usr/bin/env perl
#
=head1 Task 1: Uncommon Words

You are given two sentences, $line1 and $line2.

Write a script to find all uncommmon words in any order in the given two
sentences. Return ('') if none found.

	A word is uncommon if it appears exactly once in one of the sentences and
	doesn't appear in other sentence.

=head2 Example 1

Input: $line1 = 'Mango is sweet'
       $line2 = 'Mango is sour'
Output: ('sweet', 'sour')

=head2 Example 2

Input: $line1 = 'Mango Mango'
       $line2 = 'Orange'
Output: ('Orange')

=head2 Example 3

Input: $line1 = 'Mango is Mango'
       $line2 = 'Orange is Orange'
Output: ('')

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[['Mango is sweet', 'Mango is sour'],    ['sour', 'sweet'], 'Example 1'],
	[['Mango Mango',    'Orange'],           ['Orange'],        'Example 2'],
	[['Mango is Mango', 'Orange is Orange'], [''],              'Example 3'],
];

sub uncommon_words
{
	my $line1 = $_[0]->[0];
	my $line2 = $_[0]->[1];

	my %h;
	$h{$_}++ for split(/\s+/, $line1), split(/\s+/, $line2);

	my @res = sort grep {$h{$_} == 1} keys %h;
	return @res ? \@res : [''];
}

for (@$cases) {
    is(uncommon_words($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
