#!/usr/bin/perl
# 
# TASK #2 - Wheatstone-Playfair
# 
# Implement encryption and decryption using the Wheatstone-Playfair cipher:
# 
# https://en.wikipedia.org/wiki/Playfair_cipher
# 
# Examples:
# 
# (These combine I and J, and use X as padding.)
# 
# encrypt("playfair example", "hide the gold in the tree stump") = "bmodzbxdnabekudmuixmmouvif"
# 
# decrypt("perl and raku", "siderwrdulfipaarkcrw") = "thewexeklychallengex"
# 
# MY NOTES: hmmm.  Not too hard.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use List::Util qw(min max);
use Data::Dumper;

my $debug=0;
die "Usage: playfair-cipher [--debug] encrypt|decrypt sentence key\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==3;
my( $mode, $text, $key ) = @ARGV;
die "bad mode $mode\n" unless $mode eq "encrypt" || $mode eq "decrypt";

=pod

=head2 my @table = make_table( $key );

Make the Playfair 5x5 table from the key.

=cut
fun make_table( $key )
{
	$key = uc($key);
	$key =~ s/J/I/g;
	$key =~ tr/ //d;

	my %used = ();		# set of letters we've used

	my $tabstr;
	foreach my $letter (split(//,$key))
	{
		next if $used{$letter};
		$tabstr .= $letter;
		$used{$letter}++;
	}
	$used{J}++ if $used{I};
	$used{I}++ if $used{J};

	foreach my $letter ('A'..'Z')
	{
		next if $used{$letter};
		$tabstr .= $letter;
	}

	# convert $tabstr to the final table..
	my $len = length($tabstr);
	die "make_table: table string $tabstr (len $len) should be len 25\n"
		unless $len == 25;
	my @result = map { $tabstr =~ s/^(.....)//; $1; } 1..5;
	return @result;
}


=pod

=head2 my @pairs = split_pairs( $text );

Split $text into 2-letter pairs, obeying the special
Playfair rules described in the wikipedia page.

=cut
fun split_pairs( $text )
{
	$text = uc($text);
	$text =~ tr/ //d;
	my @result;
	while( length($text)>0 )
	{
		my $len = length($text);
		my $fst = substr($text,0,1);
		my $scd = $len>1 ? substr($text,1,1) : 'X';
		say "debug: text=$text, len=$len, fst=$fst, scd=$scd" if $debug;
		if( $fst eq $scd )
		{
			push @result, "${fst}X";
			$text =~ s/^.//;
		} else
		{
			push @result, "$fst$scd";
			$text =~ s/^..?//;
		}
	}
	return @result;
}


=pod

=head2 my( $r, $c ) = find_in_table( $letter, $tableref );

Find $letter in the 5x5 table @$tableref, returning
the ( row, column ) position.

=cut
fun find_in_table( $letter, $tableref )
{
	$letter = 'I' if $letter eq 'J';
	foreach my $r (0..4)
	{
		foreach my $c (0..4)
		{
			return ( $r, $c ) if
				$letter eq substr( $tableref->[$r], $c, 1 );
		}
	}
}


=pod

=head2 my $ecpair = e_d( $pair, $tableref, $mode );

Encrypt (or decrypt if $mode is 'decrypt') the
given 2-letter pair $pair, using $tableref as
a reference to the 5x5 table.  Return the result.

=cut
fun e_d( $pair, $tableref, $mode )
{
	my $offset = 1;
	$offset = -1 if $mode eq 'decrypt';

	my $fst = substr($pair,0,1);
	my $snd = substr($pair,1,1);
	my( $fr, $fc ) = find_in_table( $fst, $tableref );
	my( $sr, $sc ) = find_in_table( $snd, $tableref );
	#die "debug e_d, pair=$pair, fst=$fst, snd=$snd, fr=$fr, fc=$fc, sr=$sr, sc=$sc\n";

	if( $fr==$sr )			# on same row
	{
		$fc += $offset; $fc %= 5;
		$sc += $offset; $sc %= 5;
		return substr( $tableref->[$fr], $fc, 1 ).
		       substr( $tableref->[$fr], $sc, 1 );
	} elsif( $fc==$sc )		# on same column
	{
		$fr += $offset; $fr %= 5;
		$sr += $offset; $sr %= 5;
		return substr( $tableref->[$fr], $fc, 1 ).
		       substr( $tableref->[$sr], $fc, 1 );
	} else				# form a rectangle
	{
		# (fr,fc) is one corner, (sr,sc) the other
		return substr( $tableref->[$fr], $sc, 1 ).
		       substr( $tableref->[$sr], $fc, 1 );
	}
}


my @table = make_table( $key );
#die Dumper \@table;

my @pairs = split_pairs( $text );
#die Dumper \@pairs;

my $result = "";
foreach my $pair (@pairs)
{
	$result .= e_d( $pair, \@table, $mode );
}
say $result;
