use strict;
use warnings;

#Colourful Number
#Write a script to display all Colorful Number with 3 digits.
#
#A number can be declare Colorful Number where all the products of consecutive subsets of digit are different.
#
#For example, 263 is a Colorful Number since 2, 6, 3, 2x6, 6x3, 2x6x3 are unique.

my @aNumber;
my $digits = 3;
my $random_number;
my $number = '';
my $first = '';
my $second = '';
my $third = '';
my $firstMult = '';
my $secondMult = '';
my $thirdMult = '';
my $fourthMult = '';

createNumber();
checkNumber();


sub createNumber {
	
	for (my $i = 0; $i < $digits; $i++) {
		$random_number = int(rand(10));
        $aNumber[$i] = $random_number;
		$number = $number.$random_number;
	}

}

sub checkNumber {

	$first = $aNumber[0];
	$second = $aNumber[1];
	$third = $aNumber[2];
	$firstMult = $first * $second;
	$secondMult = $first * $third;
	$thirdMult = $second * $third;
	$fourthMult = $first * $second * $third;
	
	if ($first != $second and $first != $third and $second != $third
		and $firstMult != $first and $firstMult != $second and $firstMult != $third
		and $secondMult != $first and $secondMult != $second and $secondMult != $third
		and $thirdMult != $first and $thirdMult != $second and $thirdMult != $third
		and $fourthMult != $first and $fourthMult != $second and $fourthMult != $third
		and $firstMult != $secondMult and $firstMult != $second and $secondMult != $third) {
		print "The number $number is a colorful Number";		
	}
	else {
		print "The number $number is not a colorful Number";
	}
	
}

