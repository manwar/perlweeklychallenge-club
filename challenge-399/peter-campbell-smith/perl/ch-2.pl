#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/399/2

use v5.26;    # The Weekly Challenge - 2026-11-09
use utf8;     # Week 399 - task 2 - Longest absolute path
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

longest_absolute_path('dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2');
longest_absolute_path('file1.txt\nfile2.ext\na.png');
longest_absolute_path('my documents\n\tproject v1.0\n\t\t' .
	'notes v1.txt\n\timage.png');
longest_absolute_path('root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\t' .
	'e.txt');
longest_absolute_path('a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\t' .
	'very_long_directory_name\n\t\tf.txt');

sub longest_absolute_path {
	
	my ($string, $depth, @node, $path, $length, $max_length, 
		$longest, $string2, $line);
	
	# initialise
	$string = '¦' . $_[0];
	$max_length = 0;
	$longest = '';
	
	# loop over lines
	$string =~ s|\\n|¦|g;
	$string =~ s|\\t|§|g;
	while ($string =~ m|¦(§*)([^¦]*)|g) {
		$depth = length($1);
		$node[$depth] = $depth == 0 ? $2 : qq[/$2];
		
		# make pretty dir structure
		$line = (' ¬ ' x $depth) . $node[$depth];
		$line =~ s|§| ¬ |g;
		$string2 .= '   ' . $line . qq[\n];
		
		# get file path and path length
		$path = '';
		$path .= qq[$node[$_]] for 0 .. $depth;
		if ($node[$depth] =~ m|\.|) {
			$length = length($path);
			if ($length > $max_length) {
				$max_length = $length;
				$longest = $path;
			} elsif ($length == $max_length) {
				$longest .= qq[, $path];
			}
		}
	}
	
	# report
	$string = $_[0];
	$string =~ s|\\|/|g;
	say qq[\nInput:  '$_[0]' - which is:\n$string2];
	if ($max_length) {
		say qq[Output: longest file path = $longest];
		say qq[                   length = $max_length];
	} else {
		say qq[Output: no files found];
	}
}
