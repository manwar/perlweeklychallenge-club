#!/usr/env/perl
##############################################################################################################
#	Perl Weekly Challenge 352 - Task 1
#	==================================
#
#	"Write a script to return all strings that are a substring of another word in the given array
#   in the order they occur."
#	See:
#		https://theweeklychallenge.org/blog/perl-weekly-challenge-352/#TASK1
#
#	Design Choices:
#		This script:
#		- Does not consider an empty string to be a substring of another string. (See test_07.)
#		- Interprets the input words as literal strings, even if they look like regexes. (See test_09.)
#
# 	v 1.0 	- Written by Philip Sharman, 2025-12-15
##############################################################################################################
use 5.36.0;
use strict;

use boolean qw(true false);
use List::Util;
use Test::More 'tests' => 9;    # <==  The number of tests. Change as required.

##############################################################################################################
###		GLOBALS																							   ###
##############################################################################################################
my $VERBOSE = false;

##############################################################################################################
###     MAIN                                                                                               ###
##############################################################################################################
test_01();
test_02();
test_03();
test_04();
test_05();
test_06();
test_07();
test_08();
test_09();

say "Done.";

##############################################################################################################
##      TESTS		                                                                                       ###
##############################################################################################################
# From the posted challenge.
sub test_01 {
	say "Test 01" if $VERBOSE;
	my @words  = ( "cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat" );
	my @output = findSubstrings( @words );
	# Output: ("cat", "dog", "dogcat", "rat")
	if ( $VERBOSE ) {
		for my $word ( @output ) {
			say $word;
		}
	}
	my @expectedOutput = ( "cat", "dog", "dogcat", "rat" );
	is_deeply( \@output, \@expectedOutput, "Test 01" );

	return;
}

# From the posted challenge.
sub test_02 {
	say "Test 02" if $VERBOSE;
	my @words  = ( "hello", "hell", "world", "wor", "ellow", "elloworld" );
	my @output = findSubstrings( @words );
	# Output: ("hell", "world", "wor", "ellow")
	if ( $VERBOSE ) {
		for my $word ( @output ) {
			say $word;
		}
	}
	my @expectedOutput = ( "hell", "world", "wor", "ellow" );
	is_deeply( \@output, \@expectedOutput, "Test 02" );
	return;
}

# From the posted challenge.
sub test_03 {
	say "Test 03" if $VERBOSE;
	my @words  = ( "a", "aa", "aaa", "aaaa" );
	my @output = findSubstrings( @words );
	# Output: ("a", "aa", "aaa")
	if ( $VERBOSE ) {
		for my $word ( @output ) {
			say $word;
		}
	}
	my @expectedOutput = ( "a", "aa", "aaa" );
	is_deeply( \@output, \@expectedOutput, "Test 03" );
	return;
}

# From the posted challenge.
sub test_04 {
	say "Test 04" if $VERBOSE;
	my @words  = ( "flower", "flow", "flight", "fl", "fli", "ig", "ght" );
	my @output = findSubstrings( @words );
	# Output: ("flow", "fl", "fli", "ig", "ght")
	if ( $VERBOSE ) {
		for my $word ( @output ) {
			say $word;
		}
	}
	my @expectedOutput = ( "flow", "fl", "fli", "ig", "ght" );
	is_deeply( \@output, \@expectedOutput, "Test 04" );
	return;
}

# From the posted challenge.
sub test_05 {
	say "Test 05" if $VERBOSE;
	my @words  = ( "car", "carpet", "carpenter", "pet", "enter", "pen", "pent" );
	my @output = findSubstrings( @words );
	# Output: ("car", "pet", "enter", "pen", "pent")
	if ( $VERBOSE ) {
		for my $word ( @output ) {
			say $word;
		}
	}
	my @expectedOutput = ( "car", "pet", "enter", "pen", "pent" );
	is_deeply( \@output, \@expectedOutput, "Test 05" );
	return;
}

# Input with just one word.
sub test_06 {
	say "Test 06" if $VERBOSE;
	my @words  = ( "car" );
	my @output = findSubstrings( @words );
	# Output: ()
	if ( $VERBOSE ) {
		for my $word ( @output ) {
			say $word;
		}
	}
	my @expectedOutput = ();
	is_deeply( \@output, \@expectedOutput, "Test 06" );
	return;
}

# Input with an empty string.
sub test_07 {
	# Question: How should we handle an empty string?  Does it count as a substring?  I'm choosing not to do so.
	say "Test 07" if $VERBOSE;
	my @words  = ( "car", "car", "car", "" );
	my @output = findSubstrings( @words );
	# Output: ()
	if ( $VERBOSE ) {
		for my $word ( @output ) {
			say $word;
		}
	}
	my @expectedOutput = ();
	is_deeply( \@output, \@expectedOutput, "Test 07" );
	return;
}

# Input that is empty.
sub test_08 {
	say "Test 08" if $VERBOSE;
	my @words  = ();
	my @output = findSubstrings( @words );
	# Output: ()
	if ( $VERBOSE ) {
		for my $word ( @output ) {
			say $word;
		}
	}
	my @expectedOutput = ();
	is_deeply( \@output, \@expectedOutput, "Test 08" );
	return;
}

# Input with regexes.
sub test_09 {
	# Words that look like regexes can cause trouble.
	# Do we want to interpret them as regexes or as plain strings? I'm choosing to interpret them as plain strings.
	say "Test 09" if $VERBOSE;
	my @words  = ( ".*", "car", "cars", "dog" );
	my @output = findSubstrings( @words );
	# Output: ("car")
	if ( $VERBOSE ) {
		for my $word ( @output ) {
			say $word;
		}
	}
	my @expectedOutput = ( "car" );
	is_deeply( \@output, \@expectedOutput, "Test 09" );
	return;
}

##############################################################################################################
##      SUBROUTINES                                                                                        ###
##############################################################################################################
# Returns an array of all strings that are a substring of another word in the given array in the order they occur.
sub findSubstrings( @array ) {
	my @substrings;

	for my $wordToFind ( @array ) {

		$wordToFind = quotemeta( $wordToFind );    # Escape anything that looks like a regex

		if ( $wordToFind ne '' ) {                 # Ignore empty strings
			for my $testWord ( @array ) {
				# Look for a substring
				if ( $testWord =~ /$wordToFind/ ) {
					if ( $testWord ne $wordToFind ) {
						say "Found '$wordToFind' in '$testWord'." if $VERBOSE;
						push( @substrings, $wordToFind );
					}
				}
			}
		}
	}

	@substrings = List::Util::uniq( @substrings );
	return @substrings;
}

##############################################################################################################
