#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-11-11
use utf8;     # Week 295 - task 1 - Word break
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Algorithm::Combinatorics 'permutations';

word_break('onethreetwo', 'one', 'two', 'three');
word_break('sixfiveseven', 'four', 'five', 'six');
word_break('housessionwarduous', 'house', 'session', 'onward', 'arduous');
word_break('starspan', 'stars', 'star', 'span');
word_break('abcde', 'abc', 'cd', 'ab', 'bcde', 'e'); 
word_break('perakurl', 'perl', 'raku');
word_break('singsingsing', 'sing');

sub word_break {
	
	my ($str, @words, $iter, $next, $strx, $word);
	
	# initialise
	$str = shift;
	@words = @_;
	say qq[\nInput:  \$str = '$str', \@words = ('] . join(q[', '], @words) . q[')];

	# try the words in any order
	$iter = permutations(\@words);
	
	# loop over perms
	while ($next = $iter->next) {
		$strx = $str;
		
		# delete any occurrence of each word
		for $word (@$next) {
			$strx =~ s|$word| |;
			
			# solution exists if string is just spaces
			if ($strx =~ m|^ *$|) {
				say q[Output: true];
				return;
			}
		}
	}
	
	# no solution found
	say q[Output: false];
}
