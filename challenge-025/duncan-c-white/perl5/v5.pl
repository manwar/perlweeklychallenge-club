#!/usr/bin/perl
#
# Challenge 1: "Generate a longest sequence of the following "English Pokemon"
#     names where each name starts with the last letter of the previous name:
# 
#         audino bagon baltoy banette bidoof braviary bronzor carracosta
#         charmeleon cresselia croagunk darmanitan deino emboar emolga
#         exeggcute gabite girafarig gulpin haxorus heatmor heatran ivysaur
#         jellicent jumpluff kangaskhan kricketune landorus ledyba loudred
#         lumineon lunatone machamp magnezone mamoswine nosepass petilil
#         pidgeotto pikachu pinsir poliwrath poochyena porygon2 porygonz
#         registeel relicanth remoraid rufflet sableye scolipede scrafty
#         seaking sealeo silcoon simisear snivy snorlax spoink starly
#         tirtouga trapinch treecko tyrogue vigoroth vulpix wailord
#         wartortle whismur wingull yamask"
# 
# My notes: Clearly defined, nice, potentially tricky, let's do it.
# 
# optimization v5: major data structure changes: used word numbers not
#		   words in several places, used arrays not hashes    12.0s
# optimization v4: instead of extracting the last letter of each word,
#		   precalculate %lw: word->last letter of word        14.8s
# optimization v3: instead of cloning the used set to modify it,
#		   modify it, pass it, and then change it back        21.1s
# optimization v2: instead of recalculating the "used set" each time,
#		   pass it around, modifying it as we go              28.8s
# optimization v1: baseline code before starting to optimize:         32.6s.
#

use v5.10;	# to get "say"
use strict;
use warnings;
use Function::Parameters;
#use Data::Dumper;

my $debug = @ARGV>0;

my @words = qw(audino bagon baltoy banette bidoof braviary bronzor carracosta
	charmeleon cresselia croagunk darmanitan deino emboar emolga
	exeggcute gabite girafarig gulpin haxorus heatmor heatran ivysaur
	jellicent jumpluff kangaskhan kricketune landorus ledyba loudred
	lumineon lunatone machamp magnezone mamoswine nosepass petilil
	pidgeotto pikachu pinsir poliwrath poochyena porygon2 porygonz
	registeel relicanth remoraid rufflet sableye scolipede scrafty
	seaking sealeo silcoon simisear snivy snorlax spoink starly
	tirtouga trapinch treecko tyrogue vigoroth vulpix wailord
	wartortle whismur wingull yamask);
#@words = qw(hello ollie excellent thanks shelter runaround set to);

my %sw;	# hash from letter to list of word nos starting with that letter.

my %snew;# hash from letter to whether or not there ARE any words starting
	# with that latter; 0 for no, 1 for yes.

my @lw; # mapping from word no to last letter of word.

foreach my $letter ('a'..'z')
{
	$snew{$letter} = 0;
}

foreach my $wordno (0..$#words)
{
	my $word = $words[$wordno];
	$word =~ /^(.)/;
	my $letter = $1;
	$sw{$letter} //= [];
	push @{$sw{$letter}}, $wordno;
	$snew{$letter} = 1;

	$word =~ /(.)$/;
	$lw[$wordno] = $1;
}

#die Dumper \%sw;
#die Dumper \%snew;
#die Dumper \@lw;

my @longseq = ();	# longest sequence found so far..

# search for sequences starting with each word in turn..
foreach my $sw (0..$#words)
{
	findseq( $sw, [ (0) x scalar(@words)], () );
}

my $longest = @longseq;
@longseq = map { $words[$_] } @longseq;

print "\nlongest sequence is length $longest: @longseq\n";
exit 0;


#
# findseq( $currwno, $used, @seq );
#	Find all sequences of words from $currwno onwards,
#	given that we've already visited wordnos in @seq,
#	(the same info, as a set of word nos, is in @$used)
#	and update the global @longseq if any sequences
#	we find are longer than that.
#
fun findseq( $currwno, $used, @seq )
{
	push @seq, $currwno;		  # extend @seq sequence
	$used->[$currwno]=1;		  # update $used set
	my $lastletter = $lw[$currwno];	  # last letter of currw

	if( $snew{$lastletter} )	  # any words starting with letter?
	{
		foreach my $nextwordno (grep { ! $used->[$_] } @{$sw{$lastletter}})
		{
			findseq( $nextwordno, $used, @seq );
		}
	} else					# @seq is finished
	{
		#print "found sequence @seq\n";
		my $len = @seq;
		if( $len > @longseq )
		{
			print "longest seq so far (len $len): @seq\n" if $debug;
			@longseq = @seq;
		}
	}
	$used->[$currwno]=0;
}
