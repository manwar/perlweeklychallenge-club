#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-09-29
use utf8;     # Week 341 - task 1 - Broken keyboard
use warnings; # Peter Campbell Smith

binmode STDOUT, ':utf8';
use Encode;

broken_keyboard('Hello world', ['d']);
broken_keyboard('apple banana cherry', ['a', 'e']);
broken_keyboard('Coding is fun', []);
broken_keyboard('Perl and Python', ['p']);
broken_keyboard('aaaaa ccc b', ['a', 'b']);

sub broken_keyboard {
	
	my ($string, $keys, $count);
	
	# initialise and concatenate broken keys
	no warnings 'uninitialized';
	$string = $_[0];
	$keys .= $_ for @{$_[1]};
	
	# delete words containing broken keys
	$string =~ s|\w*[$keys]\w*||gi if $keys;
	
	# count the remaining words
	$count ++ while $string =~ m|\w+|gi;
	
	# report
	say qq[\nInput:  \$string = '$_[0]', \@keys = (']  . join(q[', '], @{$_[1]}) . q[')];
	say qq[Output: ] . ($count + 0);
}
