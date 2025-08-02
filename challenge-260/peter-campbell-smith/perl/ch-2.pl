#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-03-11
use utf8;     # Week 260 - task 2 - Dictionary rank
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

use Algorithm::Combinatorics 'permutations';
use Time::HiRes 'time';

dictionary_rank('CAT');
dictionary_rank('GOOGLE');;
dictionary_rank('SECRET');
dictionary_rank('MARE');
dictionary_rank('ZYMURGY');
dictionary_rank('PENGUINS');
dictionary_rank('CAMBRIDGE');
dictionary_rank('DICTIONARY');
dictionary_rank('FABRICATING');

sub dictionary_rank {
	
	my ($word, @letters, $iter, $test, $count, $this, %seen, $start);
	
	# initialise
	$start = time;
	$word = uc($_[0]);
	@letters = split('', $word);
	@letters = sort @letters;
	
	# iterate over permutations in lexicographic order
	$iter = permutations(\@letters);
	while ($test = $iter->next) {
		$this = join('', @$test);
		
		# eliminate duplicates
		next if $seen{$this};
		$seen{$this} = 1;
		
		# count them until we find $word
		$count ++;
		last if $this eq $word;
	}
	
	say qq[\nInput:  \$word = '$word'];
	say sprintf(qq[Output: $count (%.2f seconds)], time - $start);
}
