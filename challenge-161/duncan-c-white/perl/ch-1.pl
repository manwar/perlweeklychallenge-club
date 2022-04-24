#!/usr/bin/perl
# 
# TASK #1 - Abecedarian Words
# 
# An abecedarian word is a word whose letters are arranged in alphabetical
# order. For example, 'knotty' is an abecedarian word, but 'knots'
# is not. Output or return a list of all abecedarian words in the
# dictionary, sorted in decreasing order of length.
# 
# Optionally, using only abecedarian words, leave a short comment in
# your code to make your reviewer smile.
# 
# MY NOTES: ok.  Pretty easy.  Amusing phrase:
# "I am not a cellos guy"  (Jealous Guy, Roxy Music)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

#
# my $isabaced = is_abeced( $word );
#	Return 1 (true) iff $word is an Abecedarian-word, i.e. all
#	it's letters are in sorted order.
#
sub is_abeced ($)
{
	my( $word ) = @_;
	my $sig = join( '', sort split( //, $word ) );
	return $sig eq $word ? 1 : 0;
}

my $debug=0;
die "Usage: Abecedarian-words [--debug] dictionary_file\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;

my $dictfile = shift;
open( my $infh, '<', $dictfile ) ||
	die "Abecedarian-words: can't open $dictfile\n";
my @dict;
while( <$infh> )
{
	chomp;
	push @dict, lc($_);
}
close( $infh );

# sort dictionary in descending order of length
@dict = sort { length($b) <=> length($a) } @dict;

#die Dumper \@dict;

my @abeced = grep { is_abeced($_) } @dict;

say for @abeced;
