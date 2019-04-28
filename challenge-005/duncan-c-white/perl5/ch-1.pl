#!/usr/bin/perl

# Print all anagrams for a given word, using a wordlist, using the concept of
# alphabetically sorted SIGNATURES of words - simply the bag of letters in the
# word sorted.  So "hello"'s signature is "ehllo".
# The important thing for anagram purposes is that "ehllo" is the signature
# of all anagrams of hello too.
# 
# So: calculate the signature of the given word, then for every word in the
# dictionary (of the right length if we want to save time), calculate that
# dictionary word's signature - then print out the dictionary word if it's
# signature is the sameas the given word's signature.

use strict;
use warnings;
use Data::Dumper;

die "Usage: ch-1.pl word [word list filename, default /u/s/d/words\n"
	if @ARGV == 0 || @ARGV > 2;

my $word = shift;
my $wordfile = shift // "/usr/share/dict/words";

#
# my $sig = makesig( $word );
#	Build and return the SIGNATURE of the given word,
#	as described at the top of this program.  Easy to
#	do in Perl, I love "join '' sort split //"
#
sub makesig
{
	my( $word ) = @_;
	return join( '', sort split(//,$word) );
}

my $goalsig = makesig( lc($word) );

open(my $infh, '<', $wordfile) || die "can't open $wordfile\n";
while( <$infh> )
{
	chomp;
	my $sig = makesig( lc($_) );
	print "$_\n" if $sig eq $goalsig;
}
close( $infh );
