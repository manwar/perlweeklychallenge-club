#!/usr/env perl
# Perl Weekly Challenge 42-2 Script
# Write a script to generate a string with random number
# of ( and ) brackets. Then make the script validate the
# string if it has balanced brackets.

# This contains two subroutines, 1 to generate random strings, 
# (random in both length and sequence) and one to test whether
# the brackets are balanced or not.  The script also shows which
# are the unmtached brackets.
#
# With random strings, unbalanced strings are far more common
# so 100 are generated and tested
use strict; use warnings;

for (1..100){
	my $testString=randomString();          # generate random string
	printf ("  %-12s", $testString);        # display it
	print  findError($testString),  "\n";   # validate it
}

sub randomString{                           
	my $string="";                          # start with empty string
	for (0..(rand()*5+1)){                  # for a random length (2 - 7)        
		$string.=("(",")")[rand()*2];       # keep adding a random bracket
	}
	$string;                                # return the string
}

sub findError{
	my $str=shift;
	while ($str =~s/\((-*)\)/-\1-/){};      # keep replacing matched braces with
	                                        # hyphens. What is left are string
	                                        # contaning unmatched brackets
	                                        # If these exist, they show locations
	                                        # of errors
	if ($str=~/\(|\)/){ return "Not ok unmatched brackets at $str "};
	"OK, Balanced brackets";
	
}
