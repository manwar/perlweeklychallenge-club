#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-05-08
use utf8;     # Week 216 task 1 - Registration number
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use List::Uniq 'uniq';

registration_number(['job', 'james', 'bjorg'], '007 JB');
registration_number(['crack', 'road', 'rac'], 'C7 RA2');
registration_number(['superlative', 'reply', 'parallel', 'ppeerrll',
	'pert', 'earl'], 'PERL 216');
registration_number(['none', 'of', 'these', 'should', 'work'], '12345');

sub registration_number {
	
	my (@words, $reg_no, $sorted_reg_no, $word, $sorted_word, $rubric);
	
	# initialise
	@words = @{$_[0]};
	$reg_no = $_[1];
	
	# sort, eliminate non-letters, make unique and lower case $reg_no
	$reg_no =~ s|[^a-z]||ig;
	$sorted_reg_no = sort_word($reg_no);
	$rubric = '';
	
	# nothing will match if $sorted_reg_no is empty (eg $reg_no == '12345')
	if ($sorted_reg_no) {
		
		# loop over words
		for $word (@words) {
			$sorted_word = sort_word($word);
			
			# remove from $sorted_word any letter not in reg_no
			$sorted_word =~ s|[^$sorted_reg_no]||gi;
			
			# and we have a result if $sorted_word and $sorted_reg_no are the same
			$rubric .= qq['$word', ] 
				if ($sorted_word eq $sorted_reg_no);
		}
	}
	
	say qq[\nInput:  \@words = ('] . join(q[', '], @words) . qq['), \$reg = '$_[1]'];
	say qq[Output: (] . substr($rubric, 0, -2) . q[)];
}

sub sort_word {
	
	# returns unique letters in word, sorted and lower-cased
	
	return join('', sort(uniq(split('', lc($_[0])))));
}

