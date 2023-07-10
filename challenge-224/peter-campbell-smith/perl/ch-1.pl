#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-07-03
use utf8;     # Week 224 task 1 - Special notes
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

special_notes('abc', 'xyz');
special_notes('scriptinglanguage', 'perl');
special_notes('aabbcc', 'abc');
special_notes('gorge', 'george');
special_notes('fornowisthetimeforallgoodpeopletocometotheaidofthebaby', 'hyperbolicparaboloid');

sub special_notes {
    
    my ($source, $target, $letter, %letters, $good);
    
    ($source, $target) = @_;
    
    # split $source into individual letters
    for $letter (split('', $source)) {
        $letters{$letter} ++;
    }    
        
	# check if $target has any letters not in $source
	$good = 'true';
	for $letter (split('', $target)) {
		if ($letters{$letter}) {
			$letters{$letter} --;
		} else {
			$good = 'false ';
			last;
		}
	}
	
	# show answer
    say qq[\nInput:  \$source = '$source'\n        \$target = '$target'];
    say qq[Output: $good];
    
}
