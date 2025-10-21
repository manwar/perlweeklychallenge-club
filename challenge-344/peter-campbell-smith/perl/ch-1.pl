#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-10-20
use utf8;     # Week 344 - task 1 - Array form compute
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

array_form_compute([1, 2, 3, 4], 12);
array_form_compute([2, 7, 4], 181);
array_form_compute([9, 9, 9], 1);
array_form_compute([0, 1, 2, 3, 4], -17);
array_form_compute([1, 2, 3, 4], -1000);
array_form_compute([1, 2, 3, 4], -1234);
array_form_compute([0], 12345);

sub array_form_compute {
	
	say qq[\nInput:  \@ints = (] . join(', ', 
		@{$_[0]}) . qq[), \$x = $_[1]];
		
	# do it
	say qq[Output: (] . 
		join(', ', split('', join('', @{$_[0]}) + $_[1]))
		. ')';
}
