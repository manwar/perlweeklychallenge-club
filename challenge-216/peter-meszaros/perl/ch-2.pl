#!/usr/bin/env perl
#
=head1 Task 2: Word Stickers

Submitted by: Mohammad S Anwar

You are given a list of word stickers and a target word.

Write a script to find out how many word stickers is needed to make up the
given target word.

=head2 Example 1:

	Input: @stickers = ('perl','raku','python'), $word = 'peon'
	Output: 2

	We just need 2 stickers i.e. 'perl' and 'python'.
	'pe' from 'perl' and
	'on' from 'python' to get the target word.

=head2 Example 2:

	Input: @stickers = ('love','hate','angry'), $word = 'goat'
	Output: 3

	We need 3 stickers i.e. 'angry', 'love' and 'hate'.
	'g' from 'angry'
	'o' from 'love' and
	'at' from 'hate' to get the target word.

=head2 Example 3:

	Input: @stickers = ('come','nation','delta'), $word = 'accommodation'
	Output: 4

	We just need 2 stickers of 'come' and one each of 'nation' & 'delta'.
	'a' from 'delta'
	'ccommo' from 2 stickers 'come'
	'd' from the same sticker 'delta' and
	'ation' from 'nation' to get the target word.

=head2 Example 4:

	Input: @stickers = ('come','country','delta'), $word = 'accommodation'
	Output: 0

	as there's no "i" in the inputs.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use POSIX;
use List::Util qw/min/;

my $cases = [
    [[['perl', 'raku',    'python'], 'peon'],          2, 'Example 1'],
    [[['love', 'hate',    'angry'],  'goat'],          3, 'Example 2'],
    [[['come', 'nation',  'delta'],  'accommodation'], 4, 'Example 3'],
    [[['come', 'country', 'delta'],  'accommodation'], 0, 'Example 4'],
];

# Based on https://algo.monster/liteproblems/691
sub word_stickers
{
    my $stickers = $_[0]->[0];
    my $word     = $_[0]->[1];

    # Initialize a queue that starts with the base state (no letters of the target are covered)
    my @statesQueue = 0;;
    # Variable to keep track of the number of stickers used
    my $numStickers = 0;

    # Target string length
    my $targetLength = length($word);

    # Boolean vector to keep track of visited states
    my @visited = (0) x (1 << $targetLength);
    $visited[0] = 1; #Starting state is visited

    # BFS to find the minimum number of stickers needed
 	while (@statesQueue) {
        # Process each state at the current level
 		for (my $t = @statesQueue; $t > 0; --$t) {
 			my $currentState = shift @statesQueue;
 
            # If all bits are set, we have covered all characters in the target
 			if ($currentState == (1 << $targetLength) - 1) {
                return $numStickers;
            }
 
            # Try to apply each sticker to this state
 			for my $sticker (@$stickers) {
 				my $nextState = $currentState;
 				my @letterCount = (0) x 26; # Count letters in the current sticker
 
                # Count the frequency of each letter in the sticker
 				for my $c (split '', $sticker) {
 					++$letterCount[ord($c) - ord('a')];
 				}
 
                # Try to use the sticker's letters to cover uncovered letters in the target
 				for (my $i = 0; $i < $targetLength; ++$i) {
 					 my $letterIndex = ord(substr($word, $i, 1)) - ord('a');
 
 					if (!($nextState & (1 << $i)) && $letterCount[$letterIndex] > 0) {
                        # Set the corresponding bit if the letter can be covered
 						$nextState |= 1 << $i;
 						--$letterCount[$letterIndex];
 					}
 				}
 
                # If we've reached a new state, mark it as visited and add it to the queue
 				if (!$visited[$nextState]) {
 					$visited[$nextState] = 1;
 					push @statesQueue, $nextState;
 				}
 			}
 		}
 		# Increment the sticker count since a new level is processed
 		++$numStickers;
 	}
    # If we've processed all states and didn't cover the whole target, return 0
 	return 0;
}

for (@$cases) {
    is(word_stickers($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
