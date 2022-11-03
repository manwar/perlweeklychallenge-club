#!/usr/bin/perl

=head1
Week 189:
	https://theweeklychallenge.org/blog/perl-weekly-challenge-189

Task #1: Greater Character
	You are given an array of characters (a..z) and a target character.
	Write a script to find out the smallest character in the given array lexicographically greater than the target character.

=cut

use Test2::V0;

is smallest_greatest_character([qw( e m u g )], 'b'), 'e', 'Example 1';
is smallest_greatest_character([qw( d c e f )], 'a'), 'c', 'Example 2';
is smallest_greatest_character([qw( j a r )], 'o'), 'r', 'Example 3';
is smallest_greatest_character([qw( d c a f )], 'a'), 'c', 'Example 4';
is smallest_greatest_character([qw( t g a l )], 'v'), 'v', 'Example 5';

sub smallest_greatest_character {
	my ($character_array, $target_character) = @_;

	my $target_character_ascii = ord $target_character;
	my $smallest_greatest_character = 257;

	foreach my $character (@{$character_array}) {
		my $character_ascii = ord $character;
		next if $character_ascii <= $target_character_ascii;
		$smallest_greatest_character = $character_ascii if $character_ascii < $smallest_greatest_character;
	}

	return $smallest_greatest_character == 257 ? $target_character : chr $smallest_greatest_character;
}

done_testing();
