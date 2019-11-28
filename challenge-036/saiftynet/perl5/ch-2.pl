#!/usr/env perl
# Knapsack Problem
use strict;
use warnings;

#converts the table provided to a hash tolookup
my %boxes=(  r=>{weight=>1 ,amount=>1 },
             g=>{weight=>1 ,amount=>2 },
             b=>{weight=>2 ,amount=>2 },
             y=>{weight=>12,amount=>4 },
             p=>{weight=>4 ,amount=>10},
             );

my %validCombos;   # we store the valid Combinations discovered
my $maxWeight=15;  # maximum weight the knapsack can store
my $maxNumber=7;   # maximum number of boxes allowed 
my $bestAmount=0;  # best amount so far
my $bestCombo="";  # best combination of boxes
my @colours=keys %boxes;  #valid colours

for (1..7){
	$maxNumber=$_;
	resetCounters();
	addAnother("");
	print<<END;
With $maxNumber Items in knapsack,
   Best Combination is $bestCombo
   Best amount is £$bestAmount
   
END
	};
	
sub addAnother{  # recursive routine to add boxes to the knapsack
   my $list=shift;
   my $foundNew=0;
   foreach (@colours){
	  my $testCombo=join("",sort split (//,$list.$_));
	  my ($weight,$amount)=listWeightAmount($testCombo);
	  next if ( (exists $validCombos{$testCombo}) ||
	       ($weight>$maxWeight)||
	       (length($testCombo)>$maxNumber));
      $foundNew=1;
	  $validCombos{$testCombo}=$amount;
	  if ($amount>$bestAmount){   # save the best found so far
				$bestAmount=$amount;
				$bestCombo=$testCombo;
				}
	   addAnother($testCombo) 
	  }
	return if (!$foundNew);  #dont bother recuring if no new combinations found
}

# gets a string which represents a list of coloured boxed 
sub listWeightAmount{  
	my @list=split //,shift;   #convert array
	my $weight=0;my $amount=0; #initial monery and weights
	foreach (@list){
		$weight+=$boxes{$_}{weight};
		$amount+=$boxes{$_}{amount}
	}
	return $weight,$amount;    #returns a list total weight and the amount
}

sub resetCounters{#routine to reset the combinations found so far
	%validCombos=();
	$maxWeight=15;
	$bestAmount=0;
	$bestCombo="";
	
}
