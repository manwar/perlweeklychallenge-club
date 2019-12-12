#!/usr/env perl
# challenge 38 task 2
# word games
# Scrabble-like game to find highest scoring words
# I liked this game...and will use this as inspiration to make
# other games, including interactive and multiplayer games.

use strict;
use warnings;

my @words=();   # the words list to be used
my @bag=();     # a bag of letters
my %tiles=(		# the points per letter and number of letters
            a=>{count=>8,value=>1},
            b=>{count=>5,value=>4},
            c=>{count=>4,value=>5},
            d=>{count=>3,value=>3},
            e=>{count=>9,value=>2},
            f=>{count=>3,value=>3},
            g=>{count=>3,value=>1},
            h=>{count=>3,value=>5},
            i=>{count=>5,value=>1},
            j=>{count=>3,value=>2},
            k=>{count=>2,value=>10},
            l=>{count=>3,value=>2},
            m=>{count=>4,value=>5},
            n=>{count=>4,value=>4},
            o=>{count=>3,value=>5},
            p=>{count=>5,value=>3},
            q=>{count=>2,value=>10},
            r=>{count=>3,value=>2},
            s=>{count=>7,value=>1},
            t=>{count=>5,value=>5},
            u=>{count=>5,value=>1},
            v=>{count=>3,value=>2},
            w=>{count=>5,value=>3},
            x=>{count=>2,value=>1},
            y=>{count=>5,value=>2},
            z=>{count=>5,value=>1},
            ); 
            
# basic game functions, get the words, fill the bag and play the game
# these are separate functions to allow future game creation
            
getWords();  
fillBag();
runGame();

# Compile the dictionary of words. The words list may be obtained from 
# an online repository (if internet connected), a built-in words list
# on Unix/Linux/Mac machines, or the user can supply their own list.
# The list is prefiltered to remove words with more than 7 letters and
# containing non letter characters, or single letter words (e.g. I, a)
sub getWords{    
	my $validChoice=0;
	while (! $validChoice){
print <<End;

Word Game Challenge 38
Which dictionary should I use?
1- Download 400,000 word list from github.com/dwyl (public domain, Unlicensed)
2- Use internal dictionary (Unix/Mac)
3- Use user defined words list
Enter choice:-
End
	   my $reply=<>;
	   if ($reply =~/^1/){
		   use LWP::Simple qw(get);
		   @words=split /\n/, get ("https://raw.githubusercontent.com/dwyl/english-words/master/words.txt");
		   $validChoice=(@words=  grep /^[a-zA-Z]{2,7}$/, @words);
	   }
	   elsif ($reply =~/^2/){
			$validChoice=loadWordFile("/usr/share/dict/words")
		}
		elsif ($reply =~/^3/){
			print  "Enter filename: - ";
			$reply=<>; chomp $reply;
			$validChoice=loadWordFile($reply);
		}
	}
	print "\nDictonary Loaded\n\n";
	
	sub loadWordFile{
		my $file=shift;
		use File::Slurp;
		if (-e $file) {
				return @words =  grep /^[a-zA-Z]{2,7}$/, read_file($file, chomp => 1);
			}
		print "\nFile not found.";
		return 0;
	}
}

# The "Game" just picks letters from the bag 7 at a time and finds
# the best scoring words, until the bag is empty.  Modifications may be
# to only remove letters that are used, or to create a turn based game
sub runGame{
  print "\nKeep taking 7 random tiles from bag, finding best words until bag is empty\n";
  my $total=0;
  while (scalar @bag){
	my $tileset=getRandomTiles(7);
	$total+=bestWords($tileset);
  }
  print "\n Bag is empty: Total scored = $total";
}

# fills bag with all the tiles as specified by the Task, and configured 
# in %tiles
sub fillBag{					
	@bag=();   
	for my $tile (keys %tiles){
		push @bag,($tile) x $tiles{$tile}{count};
	}
}

# Randomly remove tiles from the bag.  The routine if called without
# parameters returns one tile, or if with a number returns that number
# of random tiles. The tiles returned are as string of characters.
sub getRandomTiles{ 			
	my $numberOfTiles=shift//1; 
	my $tiles="";
	for(1..$numberOfTiles){
		$tiles.=splice (@bag, int(rand(scalar @bag)), 1) if (scalar @bag)
	};
	return $tiles;
}

# Checks that a test word can be made the characters in another string
# at the same evaluates the score of the word. Returns the score, or if
# word is not found return 0
sub checkWord{
	my ($ownTiles,$testWord)=@_;
	$testWord=lc($testWord);
	my $score=0;
	my @tw=split(//,$testWord);
	while(@tw){
		my $l=pop @tw;
		if ($ownTiles=~s/$l//i){
			$score+=$tiles{$l}{value};
		}
		else {return 0}
	}
	return $score;
}

# test each word in the disctionary for possibilty of a match and keeps
# a list of the highest scoring matches 
sub bestWords{
	my $tilesIHave=shift;
	my $bestScore=0;my @bestWords=();
	foreach my $word (@words){
		my $score=checkWord($tilesIHave,$word);
		next if ($score==0);
		if ($score>$bestScore){
			@bestWords=($word);
			$bestScore=$score;
		}
		elsif ($score==$bestScore){
			push @bestWords,$word;
		}
	}
	print "Tiles '$tilesIHave' gives best score $bestScore, using word(s) '".
	      join(",",@bestWords)."'\n";
	      return $bestScore;
}


# Word Game Challenge 38
# Which dictionary should I use?
# 1- Download 400,000 word list from github.com/dwyl (public domain, Unlicensed)
# 2- Use internal dictionary (Unix/Mac)
# 3- Use user defined words list
# Enter choice:-
# 2
#
# Dictonary Loaded
#
#
# Keep taking 7 random tiles from bag, finding best words until bag is empty
# Tiles 'tuskbdt' gives best score 17, using word(s) 'tusk'
# Tiles 'niuvqws' gives best score 9, using word(s) 'wins'
# Tiles 'netmxcr' gives best score 16, using word(s) 'cent'
# Tiles 'aryochm' gives best score 21, using word(s) 'macho,mocha'
# Tiles 'finiwzn' gives best score 12, using word(s) 'Finn'
# Tiles 'pusxztl' gives best score 10, using word(s) 'puts'
# Tiles 'ijlovea' gives best score 13, using word(s) 'jovial'
# Tiles 'twbrjza' gives best score 12, using word(s) 'brat'
# Tiles 'ebaaewz' gives best score 9, using word(s) 'web'
# Tiles 'pyjassk' gives best score 14, using word(s) 'yaks'
# Tiles 'uebumgg' gives best score 10, using word(s) 'bum'
# Tiles 'pccyiey' gives best score 11, using word(s) 'epic'
# Tiles 'hdldbyv' gives best score 7, using word(s) 'dB'
# Tiles 'qefsmee' gives best score 10, using word(s) 'seem'
# Tiles 'wapogzh' gives best score 14, using word(s) 'whoa'
# Tiles 'psfa' gives best score 5, using word(s) 'SAP,asp,pas,sap,spa'

# Bag is empty: Total scored = 190



