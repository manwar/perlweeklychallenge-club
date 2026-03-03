#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-03-02
use utf8;     # Week 363 - task 1 - String lie detector
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;
use Lingua::EN::Words2Nums;
use Lingua::EN::Numbers::Easy;

string_lie_detector('aa — two vowels and zero consonants');
string_lie_detector('hello - three vowels and two consonants');
string_lie_detector('aei — three vowels and zero consonants');
string_lie_detector('perl weekly challenge - six vowels and thirteen consonants');
string_lie_detector('false example - zero vowels and zero consonants');
string_lie_detector('another example - eight consonants and six vowels');
string_lie_detector('- zero vowels and zero consonants');
string_lie_detector('supercalifragilisticexpialidocious — ' .
	'sixteen vowels and eighteen consonants');
	
sub string_lie_detector {
	
	my ($string, $claims, $subject, $v1, $c1, $v2, $c2);
	
	# initialise
	$string = $_[0];
	($subject, $claims) = $string =~ m|(.*)\s*[-—]\s*(.*)|i;
	unless (defined $subject and defined $claims) {
		say qq[\ninvalid input];
		return;
	}
	
	# analyse subject
	$v1 = $subject =~ tr|aeiou||;
	$c1 = $subject =~ tr|bcdfghjklmnpqrstvwxyz||;
	
	# analyse claims
	$v2 = $c2 = 0;
	$v2 = words2nums($1) if $claims =~ m|([a-z]+)\s+vowel|i;
	$c2 = words2nums($1) if $claims =~ m|([a-z]+)\s+consonant|i;
	
	# report
	say qq[\nInput:  '$string'];
	say qq[Output: ] . ($v1 == $v2 && $c1 == $c2 ? 
		'true' : qq[false - $N{$v1} vowels and $N{$c1} consonants]);
}
