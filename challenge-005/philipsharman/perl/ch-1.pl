#!/usr/local/bin/perl
##############################################################################################################
#	Perl Weekly Challenge 005 - Task 1
#	===================================
#	"Write a program which prints out all anagrams for a given word."
#
# 	See:
#		https://theweeklychallenge.org/blog/perl-weekly-challenge-005/
#
#	Notes:
#	- We only consider one-word anagrams.  IE, we don't consider anagrams like 'anagram' -> 'nag a ram'.
#
# 	v 1.0 	- Written by Philip Sharman, 2025-12-08
##############################################################################################################
use 5.36.0;
use strict;

use Algorithm::Combinatorics;
use boolean qw(true false);
use File::Slurper;
use List::Util;
use Term::ProgressBar;
use Test::More 'tests' => 5;    # <==  The number of tests. Change as required.

##############################################################################################################
###     GLOBALS                                                                                            ###
##############################################################################################################
my $gWordList = '../../ruben-westerberg/words_alpha.txt';
my @gAllWords;
my %gWordsOfLength;             # A hash of array-references.  The array is a list of words of the specified length.

##############################################################################################################
###     MAIN                                                                                               ###
##############################################################################################################
@gAllWords = readWordList( $gWordList );
say "Found " . scalar( @gAllWords ) . " words.";

test_1();
test_2();
test_3();
test_4();
test_5();

say "Done.";

##############################################################################################################
##      TESTS	                                                                                           ###
##############################################################################################################
# evil
sub test_1 {
	my @anagrams = findAnagrams( "evil" );
	# 	Found: evil --> levi
	# 	Found: evil --> live
	# 	Found: evil --> veil
	# 	Found: evil --> vile
	# 	Found: evil --> vlei
	my @expectedAnagrams = qw(levi live veil vile vlei);
	is_deeply( \@anagrams, \@expectedAnagrams, 'Test 01' );
}

# abcabc
sub test_2 {
	my @anagrams = findAnagrams( "abcabc" );
	# No anagrams found.
	my @expectedAnagrams = qw();
	is_deeply( \@anagrams, \@expectedAnagrams, 'Test 02' );
}

# teacher
sub test_3 {
	my @anagrams = findAnagrams( "teacher" );
	# 	Found: teacher --> cheater
	# 	Found: teacher --> hectare
	# 	Found: teacher --> rechate
	# 	Found: teacher --> recheat
	# 	Found: teacher --> reteach
	my @expectedAnagrams = qw(cheater hectare rechate recheat reteach);
	is_deeply( \@anagrams, \@expectedAnagrams, 'Test 03' );
}

# reaches
sub test_4 {
	my @anagrams = findAnagrams( "reaches" );
	# 	Found: reaches --> archsee
	# 	Found: reaches --> rechase
	my @expectedAnagrams = qw(archsee rechase);
	is_deeply( \@anagrams, \@expectedAnagrams, 'Test 04' );
}

# silent
sub test_5 {
	my @anagrams = findAnagrams( "silent" );
	# 	Found: silent --> enlist
	# 	Found: silent --> inlets
	# 	Found: silent --> listen
	# 	Found: silent --> slinte
	# 	Found: silent --> tinsel
	my @expectedAnagrams = qw(enlist inlets listen slinte tinsel);
	is_deeply( \@anagrams, \@expectedAnagrams, 'Test 05' );
}

##############################################################################################################
##      SUBROUTINES                                                                                        ###
##############################################################################################################
sub findAnagrams( $string ) {
	die unless $string =~ /^[a-z]+$/;

	say "Examining: '$string' ...";
	my $start_time = Time::HiRes::gettimeofday();

	# Get candidate words of the correct length
	my $wordList;
	my $stringLength = length( $string );
	if ( not $gWordsOfLength{ $stringLength } ) {
		$gWordsOfLength{ $stringLength } = findWordsOfLength( $stringLength );
	}
	my @wordList = @{ $gWordsOfLength{ $stringLength } };

	# Find permutations of the input string
	# (Note: This can be very slow for large words. It can also take up a lot of memory.)
	say "Finding permutations ...";
	my @letters      = split( //, $string );
	my @permutations = Algorithm::Combinatorics::permutations( \@letters );
	say "Found " . scalar( @permutations ) . " permutations of '$string'.";

	# See if any of those permutations match the input string
	my @anagrams;
	my $progressBar = Term::ProgressBar->new( { name => 'Progress', count => scalar( @permutations ), remove => 1, term_width => 60 } );
	my $i           = 0;
	for my $permutation_ArrayRef ( @permutations ) {
		my $permutation = join( '', @{ $permutation_ArrayRef } );
		next if $permutation eq $string;

		for my $word ( @wordList ) {
			if ( $word eq $permutation ) {
				push( @anagrams, $permutation );
			}
		}

		$i++;
		$progressBar->update( $i );
	}
	$progressBar->update( scalar( @permutations ) );

	# Show the results
	@anagrams = sort ( List::Util::uniq( @anagrams ) );
	if ( scalar( @anagrams ) == 0 ) {
		say "No anagrams found.";
	} else {
		for my $anagram ( @anagrams ) {
			say "Found: $string --> $anagram";
		}
	}

	# Show the time taken
	my $stop_time = Time::HiRes::gettimeofday();
	printf( "Time taken: %.2f seconds.\n", $stop_time - $start_time );

	return @anagrams;
}

##############################################################################################################
sub readWordList( $file ) {
	my @words = File::Slurper::read_lines( $file );
	return @words;
}

##############################################################################################################
sub findWordsOfLength( $stringLength ) {
	my @wordsOfCorrectLength;
	for my $word ( @gAllWords ) {
		if ( length( $word ) == $stringLength ) {
			push( @wordsOfCorrectLength, $word );
		}
	}
	say "Found " . scalar( @wordsOfCorrectLength ) . " candidate words of length $stringLength.";
	return \@wordsOfCorrectLength;
}

##############################################################################################################

