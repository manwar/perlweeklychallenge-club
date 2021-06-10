#!/usr/bin/perl
# 
# Task 1: "Canonical Path
# 
# You are given a string path, starting with a slash '/'.
# 
# Write a script to convert the given absolute path to the simplified canonical path.
# 
# In a Unix-style file system:
# 
# - A period '.' refers to the current directory
# - A double period '..' refers to the directory up a level
# - Multiple consecutive slashes ('//') are treated as a single slash '/'
# 
# The canonical path format:
# 
# - The path starts with a single slash '/'.
# - Any two directories are separated by a single slash '/'.
# - The path does not end with a trailing '/'.
# - The path only contains the directories on the path from the root
#   directory to the target file or directory
# 
# Example
# 
# Input: "/a/"
# Output: "/a"
# 
# Input: "/a/b//c/"
# Output: "/a/b/c"
# 
# Input: "/a/b/c/../.."
# Output: "/a"
# "
# 
# My notes: ok, I like this.  Pretty straightforward, but a nice practical problem.
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
#use Data::Dumper;

#
# my $canon = canonical_path( $path );
#	Find the canonical version of $path, according
#	to the rules above.
#
fun canonical_path( $path )
{
	$path =~ s|//+|/|g;		# turn //+ -> /
	$path =~ s|^/||;		# remove initial /
	$path =~ s|/$||;		# remove trailing /

	#die $path;

	my @p;
	foreach my $x (split( m|/|, $path ))
	{
		if( $x eq '..' )
		{
			pop @p;
		}
		elsif( $x ne '.' )
		{
			push @p, $x;
		}
	}

	return '/'. join('/',@p);
}


die "Usage: canonical-path PATH\n" unless @ARGV==1;
my $path = shift;

my $canon = canonical_path( $path );

say "Input:  $path";
say "Output: $canon";
