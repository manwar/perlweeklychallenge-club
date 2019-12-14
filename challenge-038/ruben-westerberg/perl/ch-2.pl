#!/usr/bin/env perl
use strict;
use warnings;
use List::Util;

my %tileBag;	#Bag of all tiles
my %values;	#Map of letter to value/score

my @l=split "", "AGISUXZEJLRVYFDPWBNTOHMCKQ";
my @c=(8,3,5,7,5,2,5,9,3,3,3,3,5,3,3,5,5,5,4,5,3,3,4,4,2,2);
my @v=((1)x7, (2)x6,(3)x4,(4)x2,(5)x5,(10)x2);

for (0..$#l) {
	$tileBag{$l[$_]}=$c[$_];
	$values{$l[$_]}=$v[$_];
}
my @words=buildValidWordList();
my $draw=join "", map {drawTile(\%tileBag)} 1..7;
my %contenders=contenderWords($draw,\@words);
print "Contenders (word: score):\n";
my @sorted=sort { $contenders{$a} <=> $contenders{$b} } keys %contenders;
print "$_: $contenders{$_}\n" for @sorted;
print "\nTiles Drawn: $draw\n";

=item contenderWords()
Finds all matching words in valid word list from the drawing letters
Returns a hash of the contender word and it score
=cut
sub contenderWords {
	my ($draw,$validWordList)=@_;
	my %words;		
	my $w=join "", sort split "", $draw;
	for (@$validWordList) {
		my @t=sort split "",$_;
		my $re=join "",@t;
		if($w =~ /$re/) {
			my $sum=List::Util::sum(@values{@t});
			$words{$_}=$sum;
		}
	}
	%words;
}

=item drawTile()
Draws a tile from the tile bag. The bag is adjusted by removing the tile
=cut

sub drawTile {
	my $tileBag=shift;
	my $total= List::Util::sum(values %$tileBag);
	my $i=int rand($total);
	my $t=0;
	my $selected;
	for ("A".."Z") {
		$t+=$$tileBag{$_};
		if ($t>$i) {
			$$tileBag{$_}--;
			$selected=$_;
			last;
		}
	}
	$selected;
}

=item buildValidWordList
Returns a list of words which are up to 7 letters long and which do not exceed the available tiles
=cut
sub buildValidWordList {
        open my $f, "<","../words_alpha.txt";
        my @words= grep { chomp; length($_) <= 7} map {uc} <$f>;
        grep { 	my %bag; 
		for (split "") { 
			$bag{$_}++
		};
		my $valid=1;
		for (keys %bag) {
			$valid&=($bag{$_}<=$tileBag{$_});
		}
		$valid
	} @words;

}
