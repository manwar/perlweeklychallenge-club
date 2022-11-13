#!/usr/bin/perl
# 
# Task 2: Decoded List
# 
# You are given an encoded string $s consisting of a sequence of numeric
# characters: 0..9.
# 
# Write a script to find all valid different decodings in sorted order.
# 
# Encoding is simply done by mapping A,B,C,D,# to 1,2,3,4,# etc.
# 
# Example 1
# 	Input: $s = 11
# 	Output: AA, K
# 
# 	11 can be decoded as (1 1) or (11) i.e. AA or K
# 
# Example 2
# 	Input: $s = 1115
# 	Output: AAAE, AAO, AKE, KAE, KO
# 
# 	Possible decoded data are:
# 	(1 1 1 5) => (AAAE)
# 	(1 1 15)  => (AAO)
# 	(1 11 5)  => (AKE)
# 	(11 1 5)  => (KAE)
# 	(11 15)   => (KO)
# 
# Example 3
# 	Input: $s = 127
# 	Output: ABG, LG
# 
# 	Possible decoded data are:
# 	(1 2 7) => (ABG)
# 	(12 7)  => (LG)
# 
# MY NOTES: Hmm.. may be simple "take 1 or 2 chars off the front" (if that
# front part is in 1..26 range), plus recursive processing of what's left,
# with a prefix added to each sub-solution..
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl
# into C (look in the C directory for the translation)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;


my $debug=0;
die "Usage: decoded-list [--debug] encodedstr\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;

my $str = shift;

die "decoded-list: bad string $str (must be entirely numeric)\n"
	unless $str =~ /^\d+$/;

my %enc = map { ord($_)-ord('@') => $_ } 'A'..'Z';
#die Dumper \%enc;

my @poss = decode_all( $str, '' );


=pod

=head2 my @poss = decode_all( $str, $prefix );

Decode $str, taking 1 or 2 digits off the front (as long
as the number that results is between 1..26), producing
all the possible decodings (adding $prefix to each decoding
that we produce)

=cut
fun decode_all( $str, $prefix )
{
	return ( $prefix ) if $str eq '';

	my @result;

	# try taking off the first char..
	my $first = substr($str,0,1);
	my $rem = substr($str,1);
	say "debug: first=$first, rem=$rem" if $debug;
	if( $rem ne '0' && $first ne '0' )
	{
		my $p2 = $prefix . $enc{$first};
		say "debug: recurse with first=$first, prefix=$p2" if $debug;
		@result = decode_all( $rem, $p2 );
	}

	if( length($str) > 1 )
	{
		# try taking off the first two chars..
		$first = substr($str,0,2);
		$rem = substr($str,2);
		say "debug: first2=$first, rem=$rem" if $debug;
		if( $rem ne '0' && $first <= 26 )
		{
			my $p2 = $prefix . $enc{$first};
			say "debug: recurse with first=$first, prefix=$p2" if $debug;
			my @p = decode_all( $rem, $p2 );
			push @result, @p;
		}
	}
	return @result;
}


say join( ', ', @poss );
