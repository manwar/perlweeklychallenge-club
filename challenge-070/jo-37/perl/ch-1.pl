#!/usr/bin/perl

use Test2::V0;

# There is only one occasion where I % N differs from I:
# For C + O == N there is (C + O) % N == 0.
# So if the first character of S is moved to the end of S, then
# - the swap operations become zero-based
# - the mod operation can be omitted
# Thus the required swap can be performed by some simple block-wise
# movements utilizising array slices.
sub swapit {
	my @S = split //, shift;
	my ($C, $O) = @_;

	join '', ((@S[1 .. $#S, 0])
		[$O .. $O + $C - 1, $C .. $O - 1, 0 .. $C - 1, $O + $C .. $#S])
		[$#S, 0 .. $#S - 1];
}

is swapit('perlandraku', 3, 4), 'pndraerlaku', 'example from challenge';
is swapit('abcde', 2, 3), 'ceadb', 'hit the end';
is swapit('abcde', 2, 2), 'adebc', 'swap adjacent blocks'; 
is swapit('abcd', 2, 2), 'cdab', 'swap whole string';

done_testing;
