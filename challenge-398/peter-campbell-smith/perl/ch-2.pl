#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/398/2

use v5.26;    # The Weekly Challenge - 2026-11-02
use utf8;     # Week 398 - task 2 - String difference
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

string_difference('ab', 'bc', 'cd', 'zy');
string_difference('cba', 'fed', 'azy');
string_difference('pop', 'ada', 'beb', 'cfc');
string_difference('aaaa', 'zzzz', 'mmmm', 'aaba');
string_difference('aceg', 'bdfh', 'cegi', 'azbz');
string_difference('challenge', 'paradigm', 'dibmmfohf', 'fkdoohqjh');
string_difference('spam', 'spam', 'spam');

sub string_difference {
	
	my (@words, $word_length, $j, $k, @diff, %count);
	
	@words = @_;
	say qq[\nInput:  ('] . join(q[', '], @words) . q[')];

	# get difference arrays (as strings)
	$word_length = length($words[0]);
	for $j (0 .. $#words) {
		for $k (0 .. $word_length - 2) {
			$diff[$j] .= ord(substr($words[$j], $k + 1, 1)) -
				ord(substr($words[$j], $k, 1)) . ':';
		}
		$count{$diff[$j]} ++;
	}
	
	# seek odd man out - the difference string which occurs just once
	for $j (0 .. $#words) {
		if ($count{$diff[$j]} == 1) {
			say qq[Output: '$words[$j]'];
			return;
		}
	}
	say qq[Output: input is invalid];
}
