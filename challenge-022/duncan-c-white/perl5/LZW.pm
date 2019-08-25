#
# Lempel-Ziv-Welch (LZW) compression algorithm: encoding and decoding using
# a common dictionary.
#
# The wiki page
# https://en.wikipedia.org/wiki/Lempel%E2%80%93Ziv%E2%80%93Welch
# explains the compression algorithm very nicely."
# 
# My notes: I read the wiki page, perhaps without concentrating enough.
# Looks complicated, especially the decoding part.  Also, what's not
# quite clear is what initial alphabet both encoding and decoding should
# use?  but let's have a go anyway, hopefully building an encoder will
# start to clarify most things?
#
# Update: the encoding was very straight forward, but I struggled for
# several hours to get my head around the decoding - especially the
# special case described in the wikipedia page where the dictionary
# doesn't contain the entry.  The description was NOT CLEAR ENOUGH
# in that case (and giving an example text where the special case
# applied would have helped a lot, eg TOTOTOT was the shortest I found)
#
# Eventually, with time running out, I checked some Rosetta code
# implementations, discovered what pseudo-code the description
# really mapped onto, and adapted it to fit my code..
# 

use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;


my @dict = ( '#', 'A'..'Z' );	# LZW dictionary
my $debug = 0;			# debugging


#
# lzw_setdict( @d );
#	Set the dictionary to @d, before encoding and decoding
#
fun lzw_setdict( @d )
{
	@dict = ( '#', @d );
}


#
# lzw_setdebug( $d );
#	Set the debug flag to $d, before encoding and decoding
#
fun lzw_setdebug( $d )
{
	$debug = $d;
}


#
# my( $x, $p ) = np2( $n );
#	Find the first 2^x >= $n, return x and 2^x.
#	eg np2(1023)=10,1024, np2(1024)=10,1024, np2(1025)=11,2048
#
fun np2( $n )
{
	my $x = 1;
	my $p = 2;
	while( $p < $n )
	{
		$p *= 2;
		$x++;
	}
	return ( $x, $p );
}


#
# my $binstr = lzw_encode( $text );
#	LZW encode $text, some plain text, using a dictionary containing
#	@dictletters.  Return the encoded binary string (a sequence of 0s and 1s).
#
fun lzw_encode( $text )
{
	my $lastpos = length($text)-1;
	$text .= '#' unless substr($text,$lastpos,1) eq '#';

	my( $width, $transition ) = np2( scalar(@dict) );
	#die "width=$width, transition=$transition\n";

	my %indict = map { $dict[$_] => $_ } 0..$#dict;
	my @newdict = @dict;

	my @letter = split(//,$text);
	foreach my $pos (0..@letter-1)
	{
		my $letter = $letter[$pos];
		die "encode: letter $letter not in newdict\n"
			unless defined $indict{$letter};
		die "encode: letter $letter is the stop code!\n"
			if $letter eq '#' && $pos<@letter-1;
	}

	my $result = "";

	my $seq = shift @letter;		# first letter

	foreach my $letter (@letter)		# rest of the letters
	{
		die "encode: logic error, seq $seq not in dict\n"
			unless defined $indict{$seq};

		print "encode: seq=$seq, letter=$letter\n" if $debug;

		if( defined $indict{$seq.$letter} )	   # extend sequence
		{
			$seq .= $letter;
			next;
		}

		# otherwise: seq is in dict, but seq.letter is not
		print "$seq in dict; but ",$seq.$letter, " is not in dict\n"
			if $debug;
		my $pos = $indict{$seq};
		my $b = sprintf( "%0${width}b", $pos );
		
		# emit $b
		print "emit $b for $seq @ $pos\n" if $debug;
		$result .= $b;
		$result .= '-' if $debug;

		# append $seq.$letter to the dictionary
		$pos = @newdict;
		$seq .= $letter;
		push @newdict, $seq;
		$indict{$seq} = $pos;
		print "adding $seq to dict at $pos\n" if $debug;

		if( $pos == $transition )	# need wider binary strings
		{
			$width++;
			$transition *= 2;
			print "increasing width to $width, ".
			      "transition to $transition\n"
				if $debug;
		}

		# start again with seq = letter
		$seq = $letter;
	}

	# handle the final seq (should be something ending in the stop code)
	my $pos = $indict{$seq};
	my $b = sprintf( "%0${width}b", $pos );
	
	# emit $b
	print "emit $b for $seq @ $pos\n" if $debug;
	$result .= "$b";

	return $result;
}


#
# my $text = lzw_decode( $binstr );
#	LZW decode $binstr, a string of 0s and 1s that represents a LZW
#	compression of an unknown text, using a dictionary containing
#	@dictletters.  Return the decoded text string (hopefully plain text).
#
fun lzw_decode( $binstr )
{
	my( $width, $transition ) = np2( scalar(@dict) );
	#die "width=$width, transition=$transition\n";

	my @newdict = @dict;
	my %indict = map { $dict[$_] => $_ } 0..$#dict;

	# remove the very first width $width bit-prefix
	my $b = substr( $binstr, 0, $width, "" );

	# find the position in the dictionary
	my $pos = oct( "0b$b" );	# convert binary string->int
	my $ndict = @newdict;
	print "decoding first $b, pos=$pos, ndict=$ndict\n" if $debug;


	die "LZW_decode: first bin $b (pos $pos) not in dict, $ndict entries\n" unless $pos<$ndict;

	my $prevf = $newdict[$pos];	# previous text fragment

	my $result = $prevf;

	while( $binstr )
	{
		# remove next width $width bit-prefix
		my $b = substr( $binstr, 0, $width, "" );

		print "decoding $b, prevf=$prevf\n" if $debug;

		# find the position in the dictionary
		my $pos = oct( "0b$b" );	# convert binary string->int

		my $ndict = @newdict;

		my $f;		# current decoded text fragment

		# if pos in dict?
		if( $pos < $ndict )
		{
			$f = $newdict[$pos];
		} elsif( $pos == $ndict )
		{
			$f = $prevf . substr($prevf,0,1);
		} else
		{
			die "decode: bad pos $pos (dictionary has $ndict ".
			    "entries) result=$result, b=$b, ".
			    "binstr=$binstr)\n";
		}

		# ok, so $b represents text frag $f
		print "b $b, pos=$pos, prevf=$prevf, f=$f\n" if $debug;

		$result .= $f;

		# the next entry in the dictionary must be the WHOLE of
		# the previous fragment plus the FIRST letter of the
		# current fragment $f
		my $new = $prevf . substr($f,0,1);

		$pos = @newdict;
		print "added $new @ pos $pos\n" if $debug;

		# add it to the dictionary
		push @newdict, $new;
		$indict{$new} = $pos;

		# do we need to change the width?
		if( @newdict == $transition )
		{
			$width++;
			$transition *= 2;
			print "increasing width to $width, ".
			      "transition to $transition\n"
				if $debug;
		}

		$prevf = $f;
	}
	return $result;
}


1;
