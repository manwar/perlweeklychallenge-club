#!/usr/bin/perl

use Test2::V0;

# Search for palindromes as substrings of a given string.
# In this implementation it is a greedy, left-to-right search.
# Returns a list of palindromes or -1 if none found
sub palindromes {
	local $_ = shift;

	(m/
		( . {2,} )
		(?(?{ $1 ne reverse $1 }) (*FAIL))
	/gx, (-1) x !$1);
}

is [palindromes 'aabaab'], ['aabaa'], 'Example 1';
is [palindromes 'abbaba'], ['abba'], 'Example 2';
is [palindromes 'cdabacdbcbcd'], ['aba', 'bcb'], 'Another example';
is palindromes('abc'), -1, 'nothing found';

done_testing;
