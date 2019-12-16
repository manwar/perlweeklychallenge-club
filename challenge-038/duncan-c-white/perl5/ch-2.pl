#!/usr/bin/perl
#
# Challenge 2: "Word Game
# 
# Lets assume we have tiles as listed below, with an alphabet (A..Z)
# printed on them. Each tile has a value, e.g. A (1 point), B (4 points)
# etc. You are allowed to draw 7 tiles from the lot randomly. Then try
# to form a word using the 7 tiles with maximum points altogether. You
# don't have to use all the 7 tiles to make a word. You should try to
# use as many tiles as possible to get the maximum points.
# 
# For example, A (x8) means there are 8 tiles with letter A.
# 
# 1 point: A (x8), G (x3), I (x5), S (x7), U (x5), X (x2), Z (x5)
# 2 points: E (x9), J (x3), L (x3), R (x3), V (x3), Y (x5)
# 3 points: F (x3), D (x3), P (x5), W (x5)
# 4 points: B (x5), N (x4)
# 5 points: T (x5), O (x3), H (x3), M (x4), C (x4)
# 10 points: K (x2), Q (x2)
# "
# 
# My notes: Sounds rather like Scrabble without the board.
#

use v5.10;	# to get "say"
use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;

my %tilebag = (
	A => 8, G => 3, I => 5, S => 7,
	U => 5, X => 2, Z => 5, E => 9,
	J => 3, L => 3, R => 3, V => 3,
	Y => 5, F => 3, D => 3, P => 5,
	W => 5, B => 5, N => 4, T => 5,
	O => 3, H => 3, M => 4, C => 4,
	K => 2, Q => 2,
);


my $debug=0;

#srand(1);

# build alltiles, a weighted list of tiles to take at random
my $alltiles= join( '', map { $_ x $tilebag{$_} } sort keys %tilebag );
#print "alltiles $alltiles\n";


my %value = (
	# 1 point:
	A => 1, G => 1, I => 1, S => 1, U => 1, X => 1, Z => 1,

	# 2 points:
	E => 2, J => 2, L => 2, R => 2, V => 2, Y => 2,

	# 3 points:
	F => 3, D => 3, P => 3, W => 3,

	# 4 points:
	B => 4, N => 4,

	# 5 points:
	T => 5, O => 5, H => 5, M => 5, C => 5,

	# 10 points:
	K => 10, Q => 10,
);

#die Dumper \%value;


#
# my $hand = randomtiles( $n );
#	Select $n random tiles from $alltiles.  Return
#	an $n-letter sorted sequence of those random tiles.
#
fun randomtiles( $n )
{
	my $at = $alltiles;
	my @result;
	foreach my $i (1..$n)
	{
		my $pos = int(rand(length($at)));
		push @result, substr( $at, $pos, 1 );
		substr( $at, $pos, 1 ) = '';
	}
	return join( '', sort @result );
}


#
# my @words = readdict( $filename );
#	Read the given wordlist $filename.  Return the list of words.
#
fun readdict( $filename )
{
	open( my $fh, '<', $filename ) || die;
	my @result;
	while( <$fh> )
	{
		chomp;
		next unless /^[A-Za-z]+$/;
		$_ =~ tr/a-z/A-Z/;
		push @result, $_;
	}
	close( $fh );
	return @result;
}


#
# my $score = score( $word );
#	Score the letters of $word using the %value. Return the score.
#
fun score( $word )
{
	my $score = 0;
	foreach my $letter (split(//,$word))
	{
		$score += $value{$letter};
	}
	return $score;
}


my @words = grep { length($_)<8 } readdict( '/usr/share/dict/words' );
my %isword = map { $_ => 1 } @words;
#die Dumper \%isword;

# find highest scoring word that is a sub-bag of $hand.
my $highscore=0;
my $highscore_word;


#
# findall( $prefix, $hand );
#	Find all sub-words of $hand (starting with $prefix)
#	that are dictionary words, score each one, and find
#	the highest scored word.
#
fun findall( $prefix, $hand )
{
	#say "debug: prefix=$prefix, hand=$hand";
	my $l = length($hand);
	foreach my $pos (0..$l-1)
	{
		my $letter = substr($hand,$pos,1);
		my $w = $prefix.$letter;
		if( $isword{$w} )
		{
			my $score = score( $w );
			#say "debug: w=$w, score=$score";
			if( $score > $highscore )
			{
				$highscore = $score;
				$highscore_word = $w;
			}
		}
		my $rest = $hand;
		substr($rest,$pos,1) = '';
		findall( $w, $rest );
	}
}


die "Usage: ch-2.pl [NROUNDS]\n" if @ARGV>1;
my $nrounds = shift // 1;

my $overall_highscore=0;
my $overall_highscore_word;
my $overall_highscore_hand;
foreach (1..$nrounds)
{
	$highscore=0;
	my $hand = randomtiles( 7 );
	#my $score = score( $hand );
	findall( "", $hand );
	say "hand:$hand, highscore:$highscore, word:$highscore_word" if $debug;
	if( $highscore > $overall_highscore )
	{
		$overall_highscore = $highscore;
		$overall_highscore_word = $highscore_word;
		$overall_highscore_hand = $hand;
	}
}
say "overall: hand:$overall_highscore_hand, highscore:$overall_highscore, word:$overall_highscore_word";
