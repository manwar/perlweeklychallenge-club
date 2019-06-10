#!/usr/bin/perl

# Challenge 1: "Write a script to encode/decode Roman numerals. For example,
# given Roman numeral CCXLVI, it should return 246. Similarly, for decimal
# number 39, it should return XXXIX."


use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;


#
# my $roman = oneroman( $digit, $one, $five, $ten );
#	Given a single $digit (0..9), build and return
#	the roman-numeral equivalent, using $one, $five and $ten,
#	the roman-numeral equivalents of 1, 5 and 10.  If those were
#	'I', 'V' and 'X', the roman-numerals equivalents of each digit
#	are '', I, II, III, IV, V, VI, VII, VIII, IX
#
fun oneroman( $digit, $one, $five, $ten )
{
	return $one x $digit if $digit<4;	        # 0..3
	return "$one$five" if $digit==4;	        # 4
	return $five.($one x ($digit-5)) if $digit<9;   # 5..9
	return "$one$ten";				# 9
}


#
# my $roman = toroman( $n );
#	Given $n, a positive integer from 1..3999,
#	convert it to a roman-numeral string, eg 246 => CCXLVI
#
fun toroman( $n )
{
	die "toroman: $n should be 1..3999\n" if $n<1 || $n>3999;

	my $roman = '';

	# deal with the thousands..
	my $m = int($n/1000);
	$roman = ( 'M' x $m );
	$n %= 1000;

	# deal with the hundreds..
	$roman .= oneroman( int($n/100), 'C', 'D', 'M' );
	$n %= 100;

	# deal with the tens..
	$roman .= oneroman( int($n/10), 'X', 'L', 'C' );
	$n %= 10;

	# deal with the ones..
	$roman .= oneroman( $n, 'I', 'V', 'X' );

	return $roman;
}



#
# my $n = fromroman( $roman );
#	Given $roman, a well-formed roman-numeral string,
#	convert it to an integer.
#
fun fromroman( $roman )
{
	my $orig = $roman;
	my $result = 0;
	$result += 1000 while $roman =~ s/^M//;
	$result += 900  if    $roman =~ s/^CM//;
	$result += 500  if    $roman =~ s/^D//;
	$result += 400  if    $roman =~ s/^CD//;
	$result += 100  while $roman =~ s/^C//;
	$result += 90   if    $roman =~ s/^XC//;
	$result += 50   if    $roman =~ s/^L//;
	$result += 40   if    $roman =~ s/^XL//;
	$result += 10   while $roman =~ s/^X//;
	$result += 9    if    $roman =~ s/^IX//;
	$result += 5    if    $roman =~ s/^V//;
	$result += 4    if    $roman =~ s/^IV//;
	$result += 1    while $roman =~ s/^I//;
	die "fromroman: roman '$orig' not empty at end, $roman left over\n"
		if $roman;
	return $result;
}

die "Usage: ch-1.pl [N|ROMAN|TEST] [N|ROMAN|TEST]...\n" if @ARGV == 0;
foreach my $val (@ARGV)
{
	if( $val =~ /\d/ )
	{
		my $roman = toroman( $val );
		print "toroman($val) = $roman\n";
	}
	elsif( $val eq "TEST" )
	{
		# check it works: try converting every number to roman, and
		# then back again, and checking that you end up with...
		# "the number you first thought of":-).
		foreach my $n (1..3999)
		{
			my $roman = toroman( $n );
			my $n2 = fromroman( $roman );
			die "error: n=$n, roman=$roman, n2=$n2\n" unless $n==$n2;
			print "toroman($n)=$roman, and fromroman($roman)=$n\n";
		}
	}
	else
	{
		my $n = fromroman( $val );
		print "fromroman($val) = $n\n";
	}
}
