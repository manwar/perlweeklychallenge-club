#!/usr/bin/perl

# Peter Campbell Smith - 2022-05-23
# PWC 166 task 2

use v5.28;
use strict;
use warnings;
use utf8;

# Given a few (three or more) directories (non-recursively), display a side-by-side 
# difference of files that are missing from at least one of the directories. Do not 
# display files that exist in every directory.

# Blog: https://pjcs-pwc.blogspot.com/2022/05/d00dle5-we-are-asked-for-list-of-2-8.html

my (@dirs, $dir, $file, $width, $header, $all, %files, $line1, $line2, $prefix);

@dirs = ([qw[Arial.ttf  Comic_Sans.ttf  Georgia.ttf  Helvetica.ttf  Impact.otf  Verdana.ttf  Old_Fonts/]],
	     [qw[Arial.ttf  Comic_Sans.ttf  Courier_New.ttf  Helvetica.ttf  Impact.otf  Tahoma.ttf  Verdana.ttf]],
	     [qw[Arial.ttf  Courier_New.ttf  Helvetica.ttf  Impact.otf  Monaco.ttf  Verdana.ttf]]);

# loop over directories
$width = 0;
for $dir (0 .. scalar @dirs - 1) {
	
	# loop over files within directory
	for $file (@{$dirs[$dir]}) {
		$files{$file} .= qq[/$dir/];   # if file exists within directory n, $files{$file} matches /n/
		$width = length($file) if length($file) > $width;   # get max file name length
	}
	$all .= qq[/$dir/];   # if $files{$file} eq /0//1//2/ (etc) then file exists in all directories and is skipped below
}

# heading lines
$line1 = qq[\n];
$prefix = ' ';
for $dir (0 .. scalar @dirs - 1) {
	$line1 .= $prefix . 'dir_' . sprintf('%-' . ($width - 4) . 's', chr(ord('a') + $dir)) . ' ';
	$line2 .= $prefix . ('-' x ($width)) . ' ';
	$prefix = '| ';
}
say qq[$line1\n$line2];

# file lines
for $file (sort keys %files) {
	next if $files{$file} eq $all; # skip file if in all directories
	
	# loop over directories
	$prefix = '';
	for $dir (0 .. scalar @dirs - 1) {
		
		# file is in this directory
		if ($files{$file} =~ m|/$dir/|) {
			print sprintf($prefix . " %-${width}s", $file);
		
		# file isn't in this directory
		} else {
			print sprintf($prefix . " %-${width}s", ' ');
		}
	$prefix = ' |';
	}
	print qq[\n];
}
print qq[\n];

	