use strict;
use warnings;

#Stepping Numbers
#Write a script to accept two numbers between 100 and 999. It should then print all Stepping Numbers between them.
#
#A number is called a stepping number if the adjacent digits have a #difference of 1. For example, 456 is a stepping number but 129 is not.

#Variables
my $lowRange = 100;
my $highRange = 999;
my $firstNumber;
my $secondNumber;
my $result = '';
my $secondValor;
my $thirdValor; 
my @aNumber;

obtainFirstNumber();

sub obtainFirstNumber {
	
	print "Please, write a number between $lowRange and $highRange\n";
	$firstNumber = <>;
	$firstNumber=~ s/^\s+|\s+$//g;
	if ($firstNumber >= $lowRange and $firstNumber <= $highRange and $firstNumber != $highRange) {
		obtainSecondNumber();
	}
	else {
		obtainFirstNumber();
	}
}

sub obtainSecondNumber {
	
	print "Please, write a number between $firstNumber and $highRange\n";
	$secondNumber = <>;
	$secondNumber=~ s/^\s+|\s+$//g;
	if ($secondNumber > $firstNumber and $secondNumber <= $highRange) {
		obtainSteppingNumbers();
	}
	else {
		obtainSecondNumber();
	}
}

sub obtainSteppingNumbers {

	for (my $i=$firstNumber+'1'; $i < $secondNumber; $i++) {
	
		@aNumber = split(//,$i);
		$secondValor = $aNumber[0] + 1;
		$thirdValor = $aNumber[0] + 2;
		
		if ($secondValor == 10) {
			$secondValor = '0';
		}
		
		if ($thirdValor == 10) {
			$thirdValor = '0';
		}
		elsif ($thirdValor == 11) {
			$thirdValor = '1';
		}
		
		if ($secondValor != $thirdValor) {
			if ($aNumber[1] eq $secondValor and $aNumber[2] eq $thirdValor) {
				$result = $result.$i."\n";
			}	
		}
	}
	message();
}

sub message {
	if ($result ne '') {
		print "The stepping number for $firstNumber and $secondNumber:\n$result";
	}
	else {
		print "There are not stepping numbers for $firstNumber and $secondNumber\n";
	}
}





