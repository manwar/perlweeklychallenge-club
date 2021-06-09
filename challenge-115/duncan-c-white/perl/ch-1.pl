#!/usr/bin/perl
# 
# Task 1: "String Chain
# 
# You are given an array of strings.
# 
# Write a script to find out if the given strings can be chained to form
# a circle. Print 1 if found otherwise 0.
# 
# A string $S can be put before another string $T in circle if the last
# character of $S is same as first character of $T.
# 
# Examples:
# 
#   Input: @S = ("abc", "dea", "cd")
#   Output: 1 as we can form circle e.g. "abc", "cd", "dea".
# 
#   Input: @S = ("ade", "cbd", "fgh")
#   Output: 0 as we can't form circle.
# "
# 
# My notes: word chains are often quite hard. HOWEVER, this time it's a circular word chain
# using ALL the words, so that's much easier:
# 1. we don't have to try "what if we start with this word (for each word)", just pick one.
# 2. we must use every word.
# There's also (if needed) an obvious shortcut to speed up failure (0) case:
# fail if numwords(starting_with_a_letter) != numwords(ending_with_that_letter).
#
# (2) also implies an obvious shortcut to speed up failure (0) case:
# fail if numwords(starting_with_a_letter) != numwords(ending_with_that_letter).
# But I don't think I need implement that.
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;

my $debug = 0;
die "Usage: word-circle [--debug] Wd Wd...\n" if
	GetOptions( "debug" => \$debug ) && @ARGV==0;
my @wd = @ARGV;


# @{$start{letter}} = list of words starting with that letter
my %start;


#
# make_start( @wd );
#	Make %start from the words in @wd.
#
fun make_start( @wd )
{
	foreach my $w (@wd)
	{
		$w =~ /^(.)/;
		my $first = $1;
		$start{$first} //= [];
		push @{$start{$first}}, $w;
	}
	#die Dumper( \%start );
}


#
# my $iscircle = wordcircle( @wd );
#	Determine whether all the words in @wd form a chained word
#	circle as the problem describes.
#	Return 1 iff they do, 0 otherwise.
#
fun wordcircle( @wd )
{
	make_start( @wd );
	my $w = $wd[0];
	my $found = rec_wordcircle( $w, $w, { map { $_ => 1 } @wd } );
	return $found;
}

#
# my $iscircle = rec_wordcircle( $targetwd, $fromwd, $unused );
#	Recursive word circle finder: can you find a circle of words from
#	word $fromwd leading to word $targetwd in 1-or-more-steps, using
#	all words, with %$unused the words unused so far, using %start and %end maps.
#	Return 1 iff we can, 0 otherwise.
#
fun rec_wordcircle( $targetwd, $w, $unused )
{
	$w =~ /(.)$/;
	my $last = $1;

	my $u = join(',',sort keys %$unused );
	#say "rwc: w=$w, target=$targetwd, unused=$u, first=$first, last=$last";

	my @next = grep { $unused->{$_} } @{$start{$last}};
	if( $debug )
	{
		my $uuw = join(',', sort keys %$unused);
		say "rwc: w=$w, unused words $uuw, unused next words: ", join(',',@next);
	}
	foreach my $nextw (@next)
	{
		my %un = %$unused;			# mark $nextw as used now
		delete $un{$nextw};
		return 1 if $nextw eq $targetwd && keys %un == 0;
		next if $nextw eq $targetwd;

		my $found = rec_wordcircle( $targetwd, $nextw, \%un );
		return 1 if $found;
	}
	return 0;
}


my $iscircle = wordcircle( @wd );
say $iscircle;
