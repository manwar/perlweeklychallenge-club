#!/usr/bin/perl

use strict;

#Variables
my $random;
my @array;
my $i = 0;
my $text;
my $code = 0;


generateString();
validation();
result();

#Fuctions

#Create the string of parenthesis by generates random numbers between 0-2 (0 = '(', 1 = ')' and 2 = end).
sub generateString {
	$random = int rand(2);
	convertParenthesis();
	while ($random != 2) {
		$random = int rand(3);
		convertParenthesis();
	}
}

#Converts the numbers generated into parenthesis
sub convertParenthesis{

		if ($random == '0') {
			@array[$i] = $random; 
			$text .= '(';
			$i++;
		}
		elsif ($random == '1') {
			@array[$i] = $random; 
			$text .= ')';
			$i++;
		}

}

#Checks if the string has balanced brackets
sub validation {
	my $length = @array;
	for (my $j = 0; $j < $length; $j++) {
		if (@array[$j] == 0) {
			$code++;
		}
		elsif (@array[$j] == 1 and $code != 0) {
			$code--;
		}
		else {
			$code = 1;
			last;
		}
	}
}

#Write the string and indicate if it's ok or not
sub result {
	if ($code == 0) {
		print "$text - OK\n";
	}
	else {
		print "$text - NOT OK\n";
	}
}


