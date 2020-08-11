#!/usr/bin/env perl6

#Input data
my @l=comb "", "AGISUXZEJLRVYFDPWBNTOHMCKQ";
my @c=(8,3,5,7,5,2,5,9,3,3,3,3,5,3,3,5,5,5,4,5,3,3,4,4,2,2);
my @v=((1) xx 7, (2) xx 6,(3) xx 4,(4) xx 2,(5) xx 5,(10) xx 2).flat;

#Build bag and map structures
my BagHash $tileBag.=new-from-pairs((@l Z @c).flat.pairup); #Bag of all tiles
my %values=(@l Z @v).flat;	#Letter value map
my BagHash $drawBag;		#Bag of drawn tiles

#Draw the 7 tiles. Update bag with removed tile
for 1..7 {
	my $i=$tileBag.total.rand.Int;
	my $t=0;
	my $selected;
	for "A".."Z" {
		$t+=$tileBag{$_};
		if $t > $i {
			$tileBag{$_}--;
			$drawBag{$_}++;
			last;
		}
	}
}

#Find all words which can be made from the drawn bag
"../words_alpha.txt".IO.lines.map({.uc}).grep({$_.chars <= 7}) ==>
grep({ .comb.BagHash (<=) $drawBag; }) ==> 
map({|($_, %values{.comb}.sum)})==>
my %contenders;

#Print sores of all possible words in asscending order
my @sorted=%contenders.keys.sort({%contenders{$^a} <=> %contenders{$^b}});

put "Contenders (word: score):";
put "$_: %contenders{$_}" for @sorted;
put "\nDrawn tiles: $drawBag";
