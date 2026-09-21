#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-09-21
use utf8;     # Week 392 - task 2 - Words length product
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

words_length_product('a', 'ab', 'abc', 'd', 'de', 'def');
words_length_product('a', 'aa', 'aaa', 'aaaa');
words_length_product('meet', 'app', 'code', 'sky', 'bold');
words_length_product('a', 'ab', 'abc', 'abcd', 'efghi');
words_length_product('xyz', 'w', 'abcdefg', 'hij');
words_length_product(qw[Vertumnus is an oil painting by the Italian 
artist Giuseppe Arcimboldo depicting Rudolf II Holy Roman Emperor as 
Vertumnus the Roman god of changing seasons gardens fruit trees and 
plant growth Rudolfs portrait is composed of fruits vegetables and 
flowers and combines visual humour with political allegory presenting
him as a ruler possessing harmony with and power over nature Seized
by Swedish forces after the Thirty Years War the painting is now held
at Skokloster Castle in Sweden]);

sub words_length_product {
	
	my (@words, $a, $j, @map, $c, $w, $best, $best_words, $i, $score);
	
	# initialise
	@words = @_;
	$a = ord('a');
	
	# create bitmap of letters used in each word
	for $j (0 .. $#words) {
		$w = lc($words[$j]);
		$map[$j] = 0;
		for $c (split('', $words[$j])) {
			$map[$j] |= (1 << (ord($c) - $a));
		}
	}
	
	# find best pair of words not sharing a letter
	$best = $score = 0;
	for $i (0 .. $#words - 1) {
		for $j ($i + 1 .. $#words) {
			next if ($map[$i] & $map[$j]);
			$score = length($words[$i]) * length($words[$j]);

			# found a potential winner!
			if ($score > $best) {
				$best = $score;
				$best_words = qq['$words[$i]', '$words[$j]'];
			}
		}
	}
	
	# report
	say qq[\nInput:  '] . join(q[', '], @words) . q['];
	say qq[Output: $best] . ($best > 0 ? qq[ - $best_words] : '');
}
