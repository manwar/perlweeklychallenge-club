#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-04-20
use utf8;     # Week 370 - task 1 - Popular word
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

popular_word('Bob hit a ball, the hit BALL flew far after it was hit.', ['hit']);
popular_word('Egg, chips and beans; egg and beans; or beans and chips',
	['chips', 'egg', 'beans']);
popular_word('Write a script to return the most popular 
	word that is not banned. It is guaranteed there is at
	least one word that is not banned and the answer is 
	unique. The words in paragraph are case-insensitive 
	and the answer should be in lower case. The words 
	cannot contain punctuation symbols.', ['the', 'is']);


sub popular_word {
	
	my ($para, $banned, %count, $best, $best_word, $word);
	
	# initialise
	($para, $banned) = @_;
	
	# clean up $para
	$para = lc($para);
	$para =~ s|[^a-z ]*||g;
	
	# count frequency of words
	$count{$1} ++ while $para =~ m|([a-z]+)|g;
	
	# eliminate banned words
	delete $count{$_} for @$banned;
	
	# find most frequent
	$best = -1;
	for $word (keys %count) {
		next unless $count{$word} > $best;
		$best = $count{$word};
		$best_word = $word;
	}
	
	say qq[\nInput:  \$para = '$_[0]'];
	say qq[        \$banned = '] . join(q[', '], @$banned) . q['];
	say qq[Output: '$best_word' occurs $best times];
}
