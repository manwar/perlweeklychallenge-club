# it $200
#You have only $1 left at the start of the week. You have been given an opportunity to make it $200. 
#The rule is simple with every move you can either double what you have or add another $1. 
#Write a script to help you get $200 with the smallest number of moves.

use strict;
use warnings;
use Data::Dumper;

my $objective = 200;
my @aMoves =();

while ($objective > 1 ) {
	if ($objective % 2 == 0){
		push (@aMoves, 'double');
		$objective = $objective / 2;
	} else {
		push (@aMoves, 'add 1');
		$objective = $objective - 1;
	}
}
my $amountMoney = 1;
foreach my $move (reverse(@aMoves)){
	if ($move eq 'double'){
		print "Double $amountMoney ";
		$amountMoney = $amountMoney * 2 ;
		print "= $amountMoney\n";
	} else {
		print "Add 1 to $amountMoney ";
		$amountMoney = $amountMoney + 1 ;
		print "= $amountMoney\n";
	}
}