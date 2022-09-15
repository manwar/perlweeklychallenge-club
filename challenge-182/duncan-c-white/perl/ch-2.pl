#!/usr/bin/perl
# 
# Task 2: Common Path
# Submitted by: Julien Fiegehenn
# 
# Given a list of absolute Linux file paths, determine the deepest path
# to the directory that contains all of them.
# 
# Example
# 
# Input:
#     /a/b/c/1/x.pl
#     /a/b/c/d/e/2/x.pl
#     /a/b/c/d/3/x.pl
#     /a/b/c/4/x.pl
#     /a/b/c/d/5/x.pl
# 
# Output:
#     /a/b/c
# 
# MY NOTES: that's a really interesting problem, and I like ones related to
# filesystems as I'm a sysadmin.  Now, what data structure would be perfect
# to help us answer this question?  Is it as simple as "longest common path
# prefix so far", i.e. start as the whole dirname (remove only the file part),
# and then for each new filepath entry check whether the new entry shares the
# whole "longest common path prefix", and if not, repeatedly remove the last
# dir part until it does:-)  The point is that the common path only ever gets
# shorter as we process more paths.  Will need to ensure that the code also
# handles the / (no common path other than root) case properly.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl
# into C (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: common-path [--debug] < inputfile\n"
	unless GetOptions( "debug"=>\$debug );


#
# my $shortened = shorten( $dirpath );
#	Given a directory path $dirpath, remove the last dirpath part,
#	return what's left.
#
sub shorten ($)
{
	my( $dirpath ) = @_;
	$dirpath =~ s|/[^/]*$||;
	return $dirpath;
}


$_ = <>;
s/\s+//g;
die "common-paths: bad directory path '$_'\n" unless m|^/|;
s|/[^/]*$||;
my $commonpath = $_;
my $ncp = ($commonpath =~ tr|/||);
say "debug: initial commonpath $commonpath, has $ncp slashes" if $debug;

while( <> )
{
	chomp;
	s/\s+//g;
	die "common-paths: bad directory path '$_'\n" unless m|^/|;
	s|/[^/]*$||;
	my $dirpath = $_;

	# need to make $dirpath no longer than $commonpath
	my $ndp = ($dirpath =~ tr|/||);
	while( $ndp > $ncp )
	{
		$dirpath = shorten( $dirpath );
		$ndp--;
	}
	say "debug: commonpath $commonpath, shortened dirpath $dirpath"
		if $debug;

	next if $commonpath eq $dirpath;

	say "debug: found cp $commonpath, dp $dirpath" if $debug;

	# try repeatedly removing one dirpath chunk from both
	do {
		$commonpath = shorten( $commonpath );
		$ncp--;
		$dirpath = shorten( $dirpath );
		say "debug: shortened cp to $commonpath, dp to $dirpath" if $debug;
	} while( $commonpath ne $dirpath );
}

$commonpath = "/" if $ncp == 0;

say $commonpath;
