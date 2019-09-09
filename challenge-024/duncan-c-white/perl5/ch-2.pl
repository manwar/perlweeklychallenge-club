#!/usr/bin/perl
#
# Challenge 2: "Create a script to implement full text search functionality
# using Inverted Index..  a database index storing a mapping from content,
# such as words or numbers, to its locations in a set of documents.
# The purpose of an inverted index is to allow fast full-text searches,
# at a cost of increased processing when a document is added to the database."
# 
# My notes: One extreme to the other, an inverted index might be quite a
# lot of work.  It needs an index-creator/updater mode, and a
# search-using-index mode.
# Let's use a dbm file to store the index, specifically:
# 
# wordindocument: word -> set of document names, stored as a sorted list
# 

use v5.10;	# for "say"
use strict;
use warnings;
use Function::Parameters;
use DB_File;
use Data::Dumper;

my $usage = "Usage: ch-2.pl i[ndex] DOCUMENT[s],\n".
            "or:    ch-2.pl s[earch] keywords\n".
            "or:    ch-2.pl l[ist]\n";
die $usage unless @ARGV > 0;

my %index;
tie %index,  'DB_File', "index" || die "ch-2.pl: can't tie to index\n";

my $mode = shift @ARGV;
if( $mode =~ /^i/i )
{
	die $usage unless @ARGV;
	add( @ARGV );
} elsif( $mode =~ /^s/i )
{
	die $usage unless @ARGV;
	my %docs = search( @ARGV );
	my $docstr = join( ',', sort keys %docs );
	print "documents containing @ARGV: $docstr\n";
} elsif( $mode =~ /^l/i )
{
	while( my $w = each %index )
	{
		print "$w: $index{$w}\n";
	}
} else
{
	die $usage;
}
untie %index;


#
# addwordtoindex( $w, $filename );
#	Word $w occurs in file $filename, add this to the index.
#
fun addwordtoindex( $w, $filename )
{
	my $docset = $index{$w} // "";
	my %s = map { $_ => 1 } split( /,/, $docset );
	$s{$filename}++;
	$index{$w} = join(',', sort keys %s);
}


#
# add( @filenames );
#	Add each document named in @filename to the index.
#
fun add( @filename )
{
	foreach my $file (@filename)
	{
		open( my $infh, '<', $file ) || next;
		my %set;	# words in this file
		while( <$infh> )
		{
			chomp;
			my @wd = split( /\s+/ );
			foreach my $w (@wd)
			{
				$w =~ s/[\.,;:!?"'({\[]+$//;
				next if $set{$w}++;
				addwordtoindex( $w, $file );
			}
		}
		close( $infh );
	}
}

#
# my %docs = search( @word );
#	Search for documents containing all the words in @word.
#	using set intersection.. return a document set.
#
fun search( @word )
{
	@word = grep { defined $index{$_} } @word;
	my $w = shift @word;
	my %docset = map { $_ => 1 } split(/,/, $index{$w});
	print "$w in $index{$w}\n";
	foreach my $w (@word)
	{
		my %set2 = map { $_ => 1 } split(/,/, $index{$w});
		print "$w in $index{$w}\n";
		foreach my $w (keys %docset)
		{
			delete $docset{$w} unless $set2{$w};
		}
	}
	return %docset;
}
