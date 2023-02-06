#!/usr/bin/perl

# Peter Campbell Smith - 2023-02-06

use v5.28;
use utf8;
use warnings;
use Time::HiRes qw(time);

# Task: You are given path to two folders, $source and $target. Write a script that recursively copy the directories 
# in $source to $target, without copying any contained files.

# Blog: https://pjcs-pwc.blogspot.com/2023/02/quads-and-directory-enquiries.html

my ($base, $source, $target);

$base = '/home/pi/PWC';
$source = "$base/a/b/c";
$target = "$base/x/y";

copy_dirs($source, $target);

sub copy_dirs {
	
	my ($source, $target, @files, $f);
	($source, $target) = @_;
	
	# read the contents of $source
	chdir $source;
	opendir(DIR, '.') or die qq[cannot open $source $!];
	@files = readdir DIR;
	closedir DIR;
	
	# if there are dirs other than . and .. created them in target
	for $f (@files) {
		next if $f =~ m|^\.\.?$|;   # ignore . and ..
		next unless -d qq[$source/$f];
		mkdir qq[$target/$f] or die qq[cannot make dir $target/$f $!];
		say qq[created dir $target/$f];
		
		# recurse to create any subfolders
		copy_dirs (qq[$source/$f], qq[$target/$f]);
	}
}