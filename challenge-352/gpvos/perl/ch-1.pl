#!/usr/bin/perl -w

use strict;
use feature 'say';
use Test::More tests => 5;

sub find_substrings {
	my(@words) = @_;
	return map { $words[$_] } grep {
		my $i = $_;
		my $re = qr/\Q$words[$i]\E/;
		my $ok = 0;
		for my $j (0 .. $#words) {
			if ($i != $j && $words[$j] =~ /$re/) {
				#say "'$words[$i]' ($i) is a substring of '$words[$j]' ($j)";
				$ok = 1; # can't use return in grep
				last; # no need to check other words
			}
		} 
		$ok;
	} (0 .. $#words);
}

# I do not agree with the result of Example 1 as given in the task,
# since the task's text does not say anything about removing duplicates.
# Additionally, viewed from one of the words "dogcat", the other word "dogcat"
# is "another word in the given array" (quoting from the task),
# and since a string is always a substring of an identical word,
# those two words don't even have to match "ratcatdogcat" to be a valid match.
# So that means that if there are duplicate words in the input, all those words
# have to appear in the output.
is_deeply([ find_substrings(
	  "cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat") ],
	[ "cat", "dog", "dogcat","dogcat", "rat" ],
	"Example 1");
is_deeply([ find_substrings(
	  "hello", "hell", "world", "wor", "ellow", "elloworld") ],
	[ "hell", "world", "wor", "ellow" ],
	"Example 2");
is_deeply([ find_substrings(
	  "a", "aa", "aaa", "aaaa") ],
	[ "a", "aa", "aaa" ],
	"Example 3");
is_deeply([ find_substrings(
	  "flower", "flow", "flight", "fl", "fli", "ig", "ght") ],
	[ "flow", "fl", "fli", "ig", "ght" ],
	"Example 4");
is_deeply([ find_substrings(
	  "car", "carpet", "carpenter", "pet", "enter", "pen", "pent") ],
	[ "car", "pet", "enter", "pen", "pent" ],
	"Example 5");
done_testing();

