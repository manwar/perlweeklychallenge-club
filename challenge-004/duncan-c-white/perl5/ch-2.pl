#!/usr/bin/perl
#
#	wordbag question:
#
#	You are given a file containing a list of words (case insensitive 1 word
#	per line) and a list of letters. Print each word from the file than can
#	be made using only letters from the list. You can use each letter only
#	once (though there can be duplicates and you can use each of them once),
#	you don't have to use all the letters. (Disclaimer: The challenge was
#	proposed by Scimon Proctor)
#
#	This is a natural "bag of words" question, essentially we need to build
#	a "bag subset" operation.

use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;

die "Usage: wordbag letters < wordlist\n" unless @ARGV;

my %letterbag;		# letter -> number of frequrrences
map { $letterbag{$_}++ } map { split(//,lc($_)) } @ARGV;


#
# my $ok = word_ok( $word, %letterbag );
#	Return 1 iff every letter in $word is present in %letterbag,
#	and not present more times in $word than in %letterbag.
#
fun word_ok( $word, %letterbag )
{
	# build a bag of the letters in the word
	my %bag2;
	map { $bag2{$_}++ } split( //, lc($word) );

	# reject word if any letter in bag2 is not present at all in
	# letterbag, or is present more times in bag2 than in letterbag
	while( my( $letter, $bag2_freq ) = each %bag2 )
	{
		my $letterbag_freq = $letterbag{$letter} // 0;
		return 0 if $bag2_freq > $letterbag_freq;
	}
	return 1;
}


# for every word on stdin, print it out if it's an answer
while( <STDIN> )
{
	chomp;
	print "$_\n" if word_ok( $_, %letterbag );
}
