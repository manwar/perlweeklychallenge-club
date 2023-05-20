#!/usr/bin/perl
#
# Task 2: Word Stickers
# 
# You are given a list of word stickers and a target word.
# Write a script to find out how many word stickers is needed to make up
# the given target word.
# 
# Example 1:
# 
#   Input: @stickers = ('perl','raku','python'), $word = 'peon'
#   Output: 2
# 
#   We just need 2 stickers i.e. 'perl' and 'python'.
#   'pe' from 'perl' and
#   'on' from 'python' to get the target word.
# 
# Example 2:
# 
#   Input: @stickers = ('love','hate','angry'), $word = 'goat'
#   Output: 3
# 
#   We need 3 stickers i.e. 'angry', 'love' and 'hate'.
#   'g' from 'angry'
#   'o' from 'love' and
#   'at' from 'hate' to get the target word.
# 
# Example 3:
# 
#   Input: @stickers = ('come','nation','delta'), $word = 'accommodation'
#   Output: 4
# 
#   We just need 2 stickers of 'come' and one each of 'nation' & 'delta'.
#   'a' from 'delta'
#   'ccommo' from 2 stickers 'come'
#   'd' from the same sticker 'delta' and
#   'ation' from 'nation' to get the target word.
# 
# Example 4:
# 
#   Input: @stickers = ('come','country','delta'), $word = 'accommodation'
#   Output: 0
# 
# as there's no "i" in the inputs.
# 
# MY NOTES: ok, so the only tricky part is that each sticker may be used any
# number of times (if any of it's letters remain in the word).  It will be
# worth checking that every letter in the word is present in one or more
# stickers before starting the main search process.
# 
# GUEST LANGUAGE: I will have a go at translating ch-2.pl into C tomorrow;
# look in the C/ directory when that's done.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;
use Function::Parameters;

my $debug=0;
die "Usage: word-stickers [--debug] word stickerwordlist\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV > 1;
my $word = lc(shift);
my @sticker = split( /,/, lc(join(',',@ARGV)) );

say "debug: word: $word, sticker: ", join(',',@sticker) if $debug;


#
# my $ismissing = lettermissing( $letter, @sticker );
#	Return 1 iff $letter is missing from all the stickers in @sticker.
#	Return 0 otherwise.
#
fun lettermissing( $letter, @sticker )
{
	foreach my $s (@sticker)
	{
		return 0 if $s =~ /$letter/i;
	}
	return 1;
}


#
# my $missing = findmissing( $word, @sticker );
#	Find and return a string of all the letters that are in $word
#	but which are missing from all stickers.
#
fun findmissing( $word, @sticker )
{
	my $missing = "";
	foreach my $letter (split(//,$word))
	{
		if( lettermissing($letter,@sticker) )
		{
			$missing .= $letter;
			say "debug: found missing letter $letter" if $debug;
		}
	}
	return $missing;
}


#
# my $lettersincommon = lettersincommon( $word, $sticker );
#	Find and return a string containing all the letters that
#	$word has in common with $sticker (using each letter in
#	$sticker only once)
#
fun lettersincommon( $word, $sticker )
{
	my $common = "";
	while( $sticker )
	{
		$sticker =~ s/^(.)//;
		my $letter = $1;
		if( $word =~ s/$letter// )
		{
			$common .= $letter;
		}
	}
	return $common;
}



my $minstickers=1000000;
my @minstickers_used;


#
# findall( $word, $stickersused, @allsticker );
#	We have already used @$stickersused;
#	Find all combinations of all stickers @allsticker that
#	contain all letters in $word, and find the best (minimum)
#	number of stickers in $minstickers, and stickers themselves
#	in @minstickers_used.
#	How? well, stickers can be used (or not) whenever it contains
#	any letters in common with the word.
#
fun findall( $word, $stickersused, @allsticker )
{
	if( $word eq '' )
	{
		say "debug: found solution, stickersused = ", join(',',@$stickersused) if $debug;
		my $nwords = @$stickersused;
		if( $nwords < $minstickers )
		{
			$minstickers = $nwords;
			@minstickers_used = @$stickersused;
			say "found new best solution: min stickers ".
			    "$minstickers, stickersused = ",
			    join(',',@minstickers_used) if $debug;
		}
		return;
	}
	foreach my $sticker (@allsticker)
	{
		my $common = lettersincommon( $word, $sticker );
		next if $common eq '';
		#say "debug: lettersincommon( $word, sticker $sticker ) ".
		#    "= $common" if $debug;

		# there are two possibilities: use this sticker or don't;
		# try both..

		# try using the sticker
		say "debug: USING sticker $sticker, against $word, letters in common $common" if $debug;
		my @newsu = @$stickersused;
		push @newsu, $sticker;
		my $newword = $word;
		$newword =~ s/$_// for split(//,$common);
		say "debug: new word is <$newword>" if $debug;
		findall( $newword, \@newsu, @allsticker );

		# or try without the sticker
	}
}


my $missingletters = findmissing( $word, @sticker );
if( $missingletters ne '' )
{
	say "0";
	if( $debug )
	{
		say "debug: There are no solutions as letters $missingletters ".
		    "are missing from all stickers";
	}
	exit(0);
}

$minstickers=1000000;
@minstickers_used = ();

findall( $word, [], @sticker );

say $minstickers;
if( $debug )
{
	say "debug: stickers used: ", join(',',@minstickers_used);
}
