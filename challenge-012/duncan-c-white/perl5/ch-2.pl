#!/usr/bin/perl
#
# Challenge 2: "Write a script that finds the common directory path,
# given a collection of paths and directory separator. For example, if
# the following paths are supplied.
# 
#     /a/b/c/d
#     /a/b/cd
#     /a/b/cc
#     /a/b/c/d/e
# 
# and the path separator is /. Your script should return /a/b as the
# common directory path."
# 
# My notes:
# 
# Obvious approach: split each path on pathsep into an array,
# eg. /a/b/c/d == (a,b,c,d) note no '' before first element a
# then compare do all split arrays have "a" in pos 0? if so, prefix += "/a"
# etc.
#
# A nice test is: ./ch-2.pl / `find /usr/bin`
# which should of course report /usr/bin... and it does:-)

use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;

#
# my $prefix = findpathprefix( $sep, @p );
#	Find and return the LONGEST PATH PREFIX of all
#	the strings in @p, given the path separator is $sep.
#	eg given sep="/", the path prefix of "/a/b/c" and "a/b/d"
#	is "/a/b".  Note that the answer can be "/" if the
#	initial path element of all the paths is not identical.
#
fun findpathprefix( $sep, @p )
{
	# split each path into path segments
	my @seg;
	foreach my $path (@p)
	{
		die "findpathprefix: path $path does not start with $sep\n"
			unless $path =~ s|^$sep||;
		my @x = split( $sep, $path );
		push @seg, \@x;
	}
	#die Dumper \@seg;

	my $prefix = "";
	my $nsegs = @{$seg[0]}-1;	# number of segments in first path
	foreach my $pos (0..$nsegs)
	{
		# while identical $pos'th segment in all strings, add to prefix
		my $same = 1;
		my $s = $seg[0][$pos];
		foreach my $i (1..$#p)
		{
			$same &&= $seg[$i][$pos] eq $s;
			last unless $same;
		}
		last unless $same;
		$prefix .= "/$s";
	}
	$prefix = "/" unless $prefix;
	return $prefix;
}


die "Usage: ch-2.pl PATHSEP PATHS\n" if @ARGV < 2;

my $pathsep = shift;
my @path = @ARGV;

my $prefix = findpathprefix( $pathsep, @path );
print "prefix=$prefix\n";
