#!/usr/bin/perl

use 5.012;
use Test2::V0;

# Enable trace output:
my $verbose = 1;

our $level;
sub trace {
	say '    ' x $level, @_ if $verbose;
}

# The task states: "[the] value at each index determines how far you are
# allowed to jump further".  So I'll regard shorter jumps as valid.
# There wouldn't be much fun otherwise - and it's called a game!

# Recursive jump game.  Try jumps from the maximum allowed length
# referenced by $maxjump[0] down to 1.  On failure, set the value to a
# negative value preventing subsequent jumps to this position.
sub jump_game;
sub jump_game {
	my @maxjump = @_;

	# Convert the given numbers into references to them.  This enables
	# the modification of the original values through array slices.
	# Transform only once.
	@maxjump = map \$_, @maxjump unless ref $maxjump[0];

	local $level = ($level // -1) + 1;
	trace "at (@{[map $$_, @maxjump]})";

	# Jump length from max down to 1.
	for my $jump (reverse 1 .. ${$maxjump[0]}) {
		# If we can jump beyond the end, we can hit it as well.
		if ($jump > $#maxjump) {
			$jump = $#maxjump
		}
		# Don't ride a dead horse.
		elsif (${$maxjump[$jump]} <= 0) {
			trace "avoid jump $jump";
			next;
		}

		trace "jump $jump:";
		trace('hit the end'), return 1 if $jump == $#maxjump;

		# Recurse into the remaining numbers from the jump target
		# onwards.
		return 1 if jump_game @maxjump[$jump .. $#maxjump];
	}
	trace 'failed';

	# Record current failure by setting max to a negative value.  Any
	# value <= 0 would do, but this visibly preserves the structure of
	# the data when the trace is enabled.
	${$maxjump[0]} *=  -1;
	0;
}

ok   jump_game(1, 2, 1, 2), 'Example 1';
ok ! jump_game(2, 1, 1, 0, 2), 'Example 2';

# No solution without short jumps:
ok jump_game(2, 2, 0, 2, 9, 3, 0, 0, 0, 1), 'step back and jump precise';

ok ! jump_game(6, 5, 4, 3, 0, 0, 0, 1), 'track failures';
ok   jump_game(2, 8, 2, 0, 1, 0, 5, 2, 0, 1, 0, 1), 'jump game!'; 
ok ! jump_game(2, 8, 2, 0, 1, 0, 4, 2, 0, 1, 0, 1), 'too short'; 

done_testing;
