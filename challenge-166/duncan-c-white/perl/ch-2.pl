#!/usr/bin/perl
# 
# Task 2: K-Directory Diff
# 
# Given a few (three or more) directories (non-recursively), display a
# side-by-side difference of files that are missing from at least one of
# the directories. Do not display files that exist in every directory.
# 
# Since the task is non-recursive, if you encounter a subdirectory, append
# a /, but otherwise treat it the same as a regular file.
# 
# Example
# 
# Given the following directory structure:
# 
# dir_a:
# Arial.ttf  Comic_Sans.ttf  Georgia.ttf  Helvetica.ttf  Impact.otf  Verdana.ttf  Old_Fonts/
# 
# dir_b:
# Arial.ttf  Comic_Sans.ttf  Courier_New.ttf  Helvetica.ttf  Impact.otf  Tahoma.ttf  Verdana.ttf
# 
# dir_c:
# Arial.ttf  Courier_New.ttf  Helvetica.ttf  Impact.otf  Monaco.ttf  Verdana.ttf
# 
# The output should look similar to the following:
# 
# dir_a          | dir_b           | dir_c
# -------------- | --------------- | ---------------
# Comic_Sans.ttf | Comic_Sans.ttf  |
#                | Courier_New.ttf | Courier_New.ttf
# Georgia.ttf    |                 |
#                |                 | Monaco.ttf
# Old_Fonts/     |                 |
#                | Tahoma.ttf      |
# 
# 
# MY NOTES: this is much more appealing to me; right up my street.  Generally,
# it seems pretty simple, build a "fileindirs" mapping from file -> a list of
# which directories it's in, and form a set of all named files, then iterate
# over the "all named files" set, skipping files present in all the dirs,
# then iterating over all the dirs, using the fileindirs info to determine
# which columns to leave blank.  Need to auto-width each dir column, but that's
# trivial to do.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
#use Function::Parameters;
use List::Util qw(max);
#use Data::Dumper;


my $debug=0;
die "Usage: k-diff [--debug] dir1 dir2 dir3..\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV>=3;

my @dirs = @ARGV;

my %allset;	# set of all files seen in any dir
my %filesindirs;# mapping of filename -> list of dirs it's in
my %dirwidth;   # map dirname -> max width of any filename

foreach my $dir (@dirs)
{
	opendir(my $dh, $dir) || die "Can't opendir $dir: $!\n";
	my @files = map { -d "$dir/$_" ? "$_/" : $_ }
		    grep { $_ ne "." && $_ ne ".." }
		    readdir($dh);
	$allset{$_}++ for @files;
	foreach my $file (@files)
	{
		$filesindirs{$file} //= [];
		my $aref = $filesindirs{$file};
		push @$aref, $dir;
	}
	$dirwidth{$dir} = max map { length($_)+1 } @files;
	closedir $dh;
}

my @cells;
my @dashes;
foreach my $dir (@dirs)
{
	my $w = $dirwidth{$dir};
	push @cells, sprintf( "%-${w}s", $dir );
	push @dashes, ('-' x $w);
}
say join( ' | ', @cells );
say join( '-|-', @dashes );

foreach my $file (sort keys %allset)
{
	my $aref = $filesindirs{$file};
	next if @$aref == @dirs;		# in all dirs
	@cells = ();
	my %indir = map { $_ => 1 } @$aref;	# 
	foreach my $dir (@dirs)
	{
		my $w = $dirwidth{$dir};
		my $str = $indir{$dir} ? $file : ' ';
		$str = sprintf( "%-${w}s", $str );
		push @cells, $str;
	}
	say join( ' | ', @cells );
}
