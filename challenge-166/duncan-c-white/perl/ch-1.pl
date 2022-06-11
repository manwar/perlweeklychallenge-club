#!/usr/bin/perl
# 
# TASK 1: Hexadecimal Words
# 
# As an old systems programmer, whenever I needed to come up with a 32-bit
# number, I would reach for the tired old examples like 0xDeadBeef and
# 0xC0dedBad. I want more!
# 
# Write a program that will read from a dictionary and find 2- to 8-letter
# words that can be "spelled" in hexadecimal, with the addition of the
# following letter substitutions:
# 
#     o -> 0 (e.g., 0xf00d = "food")
#     l -> 1
#     i -> 1
#     s -> 5
#     t -> 7
# 
# You can use your own dictionary or you can simply open
# ../../../data/dictionary.txt (relative to your script's location in
# our GitHub repository) to access the dictionary of common words from
# Week #161.
# 
# Optional Extras (for an 0xAddedFee, of course!)
# 
#     Limit the number of "special" letter substitutions in any one result
#     to keep that result at least somewhat comprehensible. (0x51105010
#     is an actual example from my sample solution you may wish to avoid!)
# 
#     Find phrases of words that total 8 characters in length (e.g.,
#     0xFee1Face), rather than just individual words.
# 
# MY NOTES: ok.  Not a terribly fascinating task, forget the optional extras.
# Should be simple enough.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
#use Data::Dumper;

my %mapping = qw(a a b b c c d d e e f f o 0 l 1 i 1 s 5 t 7);

=pod

=head2 my $hexword = hexword( $word );

Return the hex-word equivalent of $word iff $word is a hex-word, otherwise ""

=cut
sub hexword ($)
{
	my( $word ) = @_;
	my $result = "";
	foreach my $let (split(//, $word))
	{
		return "" unless $mapping{$let};
		$result .= $mapping{$let};
	}
	return $result;;
}

my $debug=0;
my $minlen=2;
my $maxlen=8;
die "Usage: form-hex-word [--debug] [--minlen min] [--maxlen max]\n"
	unless GetOptions( "debug"=>\$debug,
			   "minlen=i"=>\$minlen,
			   "maxlen=i"=>\$maxlen ) && @ARGV==0;

my $longest = "";
open( my $in, '<', "../../../data/dictionary.txt" ) || die;
while( <$in> )
{
	chomp;
	my $len = length($_);
	next unless $len >= $minlen && $len <= $maxlen;
	$_ = lc($_);
	my $hw = hexword( $_ );
	next unless $hw;
	$longest = $hw if length($hw) > length($longest);
	say "$_ == $hw";
}
close( $in );

say "longest: $longest";
