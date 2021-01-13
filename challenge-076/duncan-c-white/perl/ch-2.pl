#!/usr/bin/perl
#
# Task 2: "Word Search
#
# Write a script that takes two file names. The first file would contain
# word search grid as shown below. The second file contains list of words,
# one word per line. You could even use local dictionary file.
# 
# Print out a list of all words seen on the grid, looking both orthogonally
# and diagonally, backwards as well as forwards.
# 
# Search Grid
# 
# B I D E M I A T S U C C O R S T
# L D E G G I W Q H O D E E H D P
# U S E I R U B U T E A S L A G U
# N G N I Z I L A I C O S C N U D
# T G M I D S T S A R A R E I F G
# S R E N M D C H A S I V E E L I
# S C S H A E U E B R O A D M T E
# H W O V L P E D D L A I U L S S
# R Y O N L A S F C S T A O G O T
# I G U S S R R U G O V A R Y O C
# N R G P A T N A N G I L A M O O
# E I H A C E I V I R U S E S E D
# S E T S U D T T G A R L I C N H
# H V R M X L W I U M S N S O T B
# A E A O F I L C H T O D C A E U
# Z S C D F E C A A I I R L N R F
# A R I I A N Y U T O O O U T P F
# R S E C I S N A B O S C N E R A
# D R S M P C U U N E L T E S I L
# 
# Output
# 
# Found 54 words of length 5 or more when checked against the local
# dictionary. You may or may not get the same result but that is fine.
# 
# aimed, align, antes, argos, arose, ashed, blunt, blunts, broad, buries,
# clove, cloven, constitution, constitutions, croon, depart, departed,
# enter, filch, garlic, goats, grieve, grieves, hazard, liens, malign,
# malignant, malls, margo, midst, ought, ovary, parted, patna, pudgiest,
# quash, quashed, raped, ruses, shrine, shrines, social, socializing,
# spasm, spasmodic, succor, succors, theorem, theorems, traci, tracie,
# virus, viruses, wigged
# "
# 
# My notes: oh god, really?  one question: when searching in a particular
# direction from a particular starting cell, are we supposed to find only
# the LONGEST dictionary word found in that direction?  this is normally
# the rule in wordgrid puzzles, but was not stated.  So I've coded "find
# all words in a particular direction from a particular starting cell",
# which is probably why I get many more words than mentioned above.
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;
use List::Util qw(max);

die "Usage: word-search wordgrid-filename dict-filename\n" unless @ARGV==2;
my( $gridfilename, $dictfilename ) = @ARGV;

#
# my @g = readgrid($gridfilename);
#	Read the wordgrid filename, return @g, the grid
#	(an array of array-refs).
#
fun readgrid( $gridfilename )
{
	open( my $infh, '<', $gridfilename ) || die;
	my @result;
	while( <$infh> )
	{
		chomp;
		tr/ \t//d;
		my @ch = split(//);
		push @result, \@ch;
	}
	close($infh);
	return @result;
}

#
# my %words = readdict($dictfilename);
#	Read the dictionary filename, one word per line,
#	return a hash of upper-cased plain ASCII words.
#
fun readdict( $dictfilename )
{
	open( my $infh, '<', $dictfilename ) || die;
	my %result;
	while( <$infh> )
	{
		chomp;
		$_ = uc($_);
		$result{$_}++ if /^[A-Z][A-Z]+$/;
	}
	close($infh);
	return %result;
}


my @dir =
(
	[-1,0],	# up (delta r,c)
	[-1,1], # ne
	[0,1],  # e
	[1,1],  # se
	[1,0],  # down
	[1,-1], # sw
	[0,-1], # w
	[-1,-1],# nw
);


#
# my %foundword = findwordsonedir($grid,$isdictword,$r,$c,$deltar,$deltac);
#	Find all dictionary words (for which $isdictword->{word} is true)
#	contained in the grid starting at ($r,$c), looking in the
#	direction represented by ($deltar,$deltac)
#	as far as you like (without falling off the grid).
#	Return the set of words found, or () if no dictionary word is found.
#
fun findwordsonedir($grid,$isdictword,$r,$c,$deltar,$deltac)
{
	my %result;
	my $rows = @$grid;
	my $cols = @{$grid->[0]};
	my $word = $grid->[$r][$c];
	for( my $len = 1; ; $len++ )
	{
		$r += $deltar;
		$c += $deltac;
		last unless $r>=0 && $r<$rows && $c>=0 && $c<$cols;
		$word .= $grid->[$r][$c];
		next unless $isdictword->{$word};
		#say "found dict word $word";
		$result{$word}++;
	} 
	my @found = sort keys(%result);
	if( @found==0 )
	{
		#say "no dict words starting from ($r,$c) in direction ($deltar,$deltac)";
	}
	else
	{
		say "dict words starting from ($r,$c) in direction ($deltar,$deltac): ",
			join(',',@found);
	}
	return %result;
}


#
# my @found = findwords( $grid, $isword );
#	Find all words (for which $isword->{word} is true)
#	contained in the grid, looking in all 8 orthogonal
#	(up/down, left/right) and diagonal directions.
#	Return the list of all such distinct words found.
#
fun findwords( $grid, $isword )
{
	my $rows = @$grid;
	my $cols = @{$grid->[0]};
	say "rows=$rows, cols=$cols";
	#say "isword(BIDE) = ", $isword->{BIDE}//"null";

	my %result;
	foreach my $r (0..$rows-1)
	{
		foreach my $c (0..$cols-1)
		{
			foreach my $dir (@dir)
			{
				my( $dr, $dc ) = @$dir;
				#say "starting at grid pos ($r,$c), dir ($dr,$dc)";
				my %foundword = findwordsonedir($grid,$isword,$r,$c,$dr,$dc);
				my @found = keys %foundword;
				next unless @found;
				@result{@found}=(1) x scalar(@found);
			}
		}
	}
	return sort(keys %result);
}


my @g = readgrid($gridfilename);
#say Dumper \@g;

my %isword = readdict($dictfilename);
#say Dumper \%isword;
##say "isword(BIDE) = ", $isword{BIDE}//"null";

my @found = findwords( \@g, \%isword );
my $n = @found;
say "found $n words in grid: ", join(',',@found);
