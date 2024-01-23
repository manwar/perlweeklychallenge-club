#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-01-22
use utf8;     # Week 253 task 1 - Split strings
use strict;   # Peter Campbell Smith
use warnings; 
binmode STDOUT, ':utf8';

split_strings(['one.two.three','four.five','six'], '.');
split_strings(['$perl$$', '$$raku$'], '$');
split_strings(['xonex', 'xtwox'], 'x');

# some edge cases
split_strings([',,,,,'], ',');
split_strings(['\\three\\blind\\', '\\mice\\'], '\\');
split_strings(['ŐőŕŒœŔŕŖ', 'ŗŘřŚŕ'], 'ŕ');

sub split_strings {
	
	my (@words, $separator, $text, @output);
	
	# initialise
	@words = @{$_[0]};
	$separator = substr($_[1] . ' ', 0, 1); # default is blank
	
	# join the input strings together with single separators
	$text = join($separator, @words);
	$text =~ s|\Q$separator\E+|$separator|g;
	
	# split that into individual words
	@output = split(/\Q$separator\E+/, $text);
	
	# remove an empty first or last word
	shift @output if (@output > 0 and $output[0] eq '');
	pop @output if (@output > 0 and $output[-1] eq '');

	# publish results
	say qq[\nInput:  \@words = ('] . join(qq[', '], @words) . qq[')];
	say qq[        \$separator = '$separator'];
	say qq[Output: ('] . join(q[', '], @output) . qq[')];	
}
