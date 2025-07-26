#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-07-28
use utf8;     # Week 332 - task 1 - Binary date
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

binary_date('2025-07-28');
binary_date('1947-11-09');
binary_date('8191-07-31');
binary_date('2730-02-21');

sub binary_date {
	
	say qq[\nInput:  \$date = '$_[0]'];
	say qq[Output: ] . sprintf("'%b-%b-%b'", 
		substr($_[0], 0, 4), substr($_[0], 5, 2), 
		substr($_[0], 8, 2));
}

