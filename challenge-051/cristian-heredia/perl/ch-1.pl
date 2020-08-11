use strict;
use warnings;

#3 Sum
#Given an array @Lof integers. Write a script to find all unique triplets such that a + b + c is same as the given target T. Also make sure a <= b <= c.
#
#Here is wiki page for more information.
#
#Example:
#
#@L = (-25, -10, -7, -3, 2, 4, 8, 10);
#
#One such triplet for target 0 i.e. -10 + 2 + 8 = 0.

my @aNumber;
my $digits = 7;
my $start = '-99';
my $end = 99;
my $random_number;
my $target = 0;
my $total;
my $message = '';

createNumber();
checkNumber();

sub createNumber {
	
	for (my $i = 0; $i < $digits; $i++) {
		$random_number = $start + int rand ($end - $start + 1);
        $aNumber[$i] = $random_number;
	}
	print "@aNumber\n";
}

sub checkNumber {
	
	for (my $j=0; $j<$digits; $j++) {
        
        for (my $k=0; $k<$digits; $k++) {
		
			if ($j != $k){
			
				for (my $l=0; $l<$digits; $l++) {
				
					if ($l != $k and $j != $l){
						$total = $aNumber[$j] +$aNumber[$k] +$aNumber[$l];
						if ($total == $target and $aNumber[$j] < $aNumber[$k] and $aNumber[$k] < $aNumber[$l]) {
							$message = $message."Result that match the criteria are the numbers: $aNumber[$j], $aNumber[$k], $aNumber[$l]\n";
							print "$message\n";
						}
					}
				}
			}
		}
	}
	if ($message eq '') {
		print "There are no results\n";
	}
}








