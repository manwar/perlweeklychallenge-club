#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-10-12
use utf8;     # Week 395 - task 2 - Word squares
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Algorithm::Combinatorics 'variations';
use Encode;

word_squares('SEE', 'TEN', 'SUN', 'NET', 'USE');
word_squares('BOAT', 'TEAL', 'AREA', 'TSAR', 'OGRE');
word_squares('CARD', 'AREA', 'REAR', 'DART');
word_squares('HEART', 'TREND', 'EMBER', 'RESIN', 'ABUSE');
word_squares('BLUE', 'GLUE', 'GLUT', 'BLUT', 'BLUZ');
word_squares('SERINETTE','ACHALASIA','ANABOLITE','ADDLEHEAD',
	'CRENIDENS','ASCENDERS', 'INITIATOR','LINOLENIN','HEXANDRIC');
word_squares('HALOBORATE','ANEITENSIS','CERRATEANA','PROCOLICIN',
	'SCAPHARCAE','RETIREMENT','ATELOMERES','EARNESTEST',
	'ARGOLETIER', 'CAICARENSE');

sub word_squares {
	
	my (@words, $n, $iter, $x, $y, $this);
	
	# initialise
	@words = @_;
	say qq[\nInput:  '] . join(q[', '], @words) . q['];
	$n = length($words[0]);
	$iter = variations(\@words, $n);
	
	# iterate over each possible subset of n n-letter words
	ITER: while ($this = $iter->next) {

		# see if they are symmetric about the x = y diagonal
		for $x (0 .. $n - 1) {
			for $y ($x + 1 .. $n - 1) {
				next ITER unless substr($this->[$x], $y, 1)
							  eq substr($this->[$y], $x, 1);
			}
		}
		
		# found a square!
		say qq[Output:];
		say join(qq[\n], '   ' . join(' ', split(//, $this->[$_]))) 
			for 0 .. $n - 1;
		return;
	}
	
	# no square found
	say qq[Output: cannot make a square];
}
