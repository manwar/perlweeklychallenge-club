#!/usr/bin/env perl
use strict;
use warnings;
use List::Util;

my @l=split "", "AGISUXZEJLRVYFDPWBNTOHMCKQ";
my @c=(8,3,5,7,5,2,5,9,3,3,3,3,5,3,3,5,5,5,4,5,3,3,4,4,2,2);
my @v=((1)x7, (2)x6,(3)x4,(4)x2,(5)x5,(10)x2);

my %tileBag;	#Bag of all tiles
my %values;	#Map of letter to value/score
my %drawBag;	#Bag of7 tiles drawn


#Build the bags and maps
for (0..$#l) {
	$tileBag{$l[$_]}=$c[$_];
	$values{$l[$_]}=$v[$_];
}

#Draw the 7 tiles. Update bag with removed tile
for (1..7) {
	my $total= List::Util::sum(values %tileBag);
	my $i=int rand($total);
	my $t=0;
	my $selected;
	for ("A".."Z") {
		$t+=$tileBag{$_};
		if ($t>$i) {
			$tileBag{$_}--;
			$drawBag{$_}++;
			last;
		}
	}
}

#Find all words which can be made from the drawn bag
my %contenders=map {($_, List::Util::sum( @values{split ""}))} possibleWords();

#Print sores of all possible words in asscending order
my @sorted=sort { $contenders{$a} <=> $contenders{$b} } keys %contenders;
print "Contenders (word: score):\n";
print "$_: $contenders{$_}\n" for @sorted;
print "\nTiles Drawn: ",join(", ", map({($_) x $drawBag{$_}} keys %drawBag)),"\n";


#Helper sub to test known words against drawn tiles
sub possibleWords {
        open my $f, "<","../words_alpha.txt";
        my @words= grep { chomp; length($_) <= 7} map {uc} <$f>;
        grep { 	my %bag; 
		for (split "") { 
			$bag{$_}++
		};
		my $valid=1;
		for (keys %bag) {
			if (defined $drawBag{$_}) {
				$valid&=($bag{$_}<=$drawBag{$_});
				next;
			}
			$valid&=0;
		}
		$valid
	} @words;
}
