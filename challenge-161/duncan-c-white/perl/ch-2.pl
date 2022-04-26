#!/usr/bin/perl
# 
# TASK #2 - Pangrams
# 
# A pangram is a sentence or phrase that uses every letter in the English
# alphabet at least once. For example, perhaps the most well known
# pangram is:
# 
# the quick brown fox jumps over the lazy dog
# 
# Using the provided dictionary, so that you don't need to include
# individual copy, generate at least one pangram.
# 
# Your pangram does not have to be a syntactically valid English sentence
# (doing so would require far more work, and a dictionary of nouns, verbs,
# adjectives, adverbs, and conjunctions). Also note that repeated letters,
# and even repeated words, are permitted.
# 
# BONUS: Constrain or optimize for something interesting (completely up
# to you), such as:
# 
# Shortest possible pangram (difficult)
# 
# Pangram which contains only abecedarian words (see challenge 1)
# 
# Pangram such that each word "solves" exactly one new letter. For example,
# such a pangram might begin with (newly solved letters in bold):
#     a ah hi hid die ice tea ...
# 
#     (What is the longest possible pangram generated with this method? All
#     solutions will contain 26 words, so focus on the letter count.)
# 
# Pangrams that have the weirdest (PG-13) Google image search results
# 
# Anything interesting goes!
# 
# 
# MY NOTES: hmmm.  Pretty easy to find a pangram in a brute force fashion,
# but anything more constrained sounds pretty hard.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use List::Util qw(min max);
use Data::Dumper;

my $debug=0;
die "Usage: find-random-pangram [--debug] dictfile\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;

my $dictfile = shift;

# read dictionary, building @dict - the list of words.
open( my $infh, '<', $dictfile ) ||
	die "find-random-pangram: can't open $dictfile\n";
my @dict;
while( <$infh> )
{
	chomp;
	$_ = lc($_);
	push @dict, $_;
}
close( $infh );


=pod

=head2 my $nunused = nunused( $word, $ustr );

Return the number of distinct unused letters (found in $ustr) that
$word contains, 0 otherwise

=cut
fun nunused( $word, $ustr )
{
	my $n = 0;
	foreach my $u (split(//,$ustr))
	{
		$n++ if $word =~ /$u/;
	}
	return $n;
}


=pod

=head2 my $word = pick_random_word( $ustr );

FIRST PANGRAM GENERATION METHOD: Pick a random word containing one of the
unused letters in $ustr

=cut
fun pick_random_word( $ustr )
{
	# pick a random word containing the first unused letter
	my $ul = substr($ustr,0,1);
	say "picking random word containing letter $ul";

	# find all words in @dict containing letter $ul
	my @w = grep { /$ul/ } @dict;

	my $randomword = $w[int rand @w];
	say "picked random word $randomword containing letter $ul" if $debug;
	return $randomword;
}


=pod

=head2 my $word = pick_random_word2( $ustr );

SECOND PANGRAM GENERATION METHOD: Sort words by how many unused letters
they have (unused letters are passed in as the alphabetically sorted
string $ustr); select the dictionary words with the greatest number of unused
letters; of those, select the shortest of those words; pink a random word
still under consideration.

This produces much shorter pangrams than the first method - average
40-45 characters, same ballpark as the shortest of all pangrams
that are good english sentences (41 chars, the quick brown fella)

=cut
fun pick_random_word2( $ustr )
{
	my @lp = map { [ nunused($_,$ustr), $_ ] } @dict;
	#die Dumper \@lp;

	# find max(number_unused_letters) in list of pairs
	my $maxul = max( map { $_->[0] } @lp );

	#die "maxul = $maxul";

	# now select all words with $maxul unused letters in them
	my @wm = map { $_->[1] } grep { $_->[0] == $maxul } @lp;

	#die Dumper \@wm;

	# now select the shortest of those
	my $minlen = min( map { length($_) } @wm );
	@wm = grep { length($_) == $minlen } @wm;

	#die Dumper \@wm;

	# pick a random one of those words
	my $randomword = $wm[int rand @wm];
	say "picked random word $randomword with $maxul unused letters" if $debug;
	return $randomword;
}


=pod

=head2 my $pg = find_pangram( $firstword );

Find a random pangram starting with the first word.

=cut
fun find_pangram( $firstword )
{
	say "starting with $firstword" if $debug;
	my $ustr = "abcdefghijklmnopqrstuvwxyz";

	my $word = $firstword;
	my @pg;

	for(;;)
	{
		push @pg, $word;
		map { $ustr =~ s/$_// } split(//,$word);
		my $nunused = length($ustr);
	last if $nunused == 0;
		say "$nunused unused letters remaining: $ustr" if $debug;
		# first method
		# $word = pick_random_word( $ustr );
		# second method
		$word = pick_random_word2( $ustr );
	}

	return join(' ', @pg);
}


=pod

=head2 my $ispg = is_pangram( $pg );

Return 1 iff $pg is a pangram, otherwise return 0.  Assume $pg is all
lower case, has no punctuation, i.e. only lower case letters and spaces.

=cut
fun is_pangram( $pg )
{
	$pg =~ s/\s//g;	# remove spaces
	my %used;
	$used{$_}++ for split(//,$pg);
	my $usig = join('', sort keys %used );
	my $l = length($usig);
	#say "is_pangram($pg): usig=$usig, len=$l" if $debug;
	return $l==26?1:0;
}


my $pg = find_pangram( $dict[int rand @dict] );
my $l = length($pg);

say "pangram: $pg, length $l";

my $ispg = is_pangram( $pg );
die "internal error: generated pangram is NOT a pangram!\n" unless $ispg;
