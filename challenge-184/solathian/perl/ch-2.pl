#!usr/bin/perl -w

#184 Task 2: Split Array

#You are given list of strings containing 0-9 and a-z separated by space only.

#Write a script to split the data into two arrays, one for integers and one for alphabets only.

use strict;
use warnings;

# Example calls

#my @list = ( 'a 1 2 b 0', '3 c 4 d');
#Output: [[1,2,0], [3,4]] and [['a','b'], ['c','d']]

#my  @list = ( '1 2', 'p q r', 's 3', '4 5 t');
#Output: [[1,2], [3], [4,5]] and [['p','q','r'], ['s'], ['t']]

#splitArray(\@list);




sub splitArray
{
    my $arrayRef = shift;
	my @numberArray;
	my @letterArray;


    
    foreach my $elem (@$arrayRef)
    {
		my @characters = split(" ", $elem);
		my @tempNumbers;
		my @tempLetters;
		
		foreach my $singleChar (@characters)
		{
			if($singleChar =~ /[a-z]{1}/)
			{
				push(@tempLetters, $singleChar);
			}
			elsif($singleChar =~ /[0-9]{1}/)
			{
				push(@tempNumbers, $singleChar);
			}
			else
			{
				die "The character is not a number neither a letter."
			}
		}
		
		# only push if the array has elements
		push(@numberArray, \@tempNumbers) if(@tempNumbers > 0);
		push(@letterArray, \@tempLetters) if(@tempLetters > 0);


    }
    
    # create output
    print("Input:(",join(",",@$arrayRef),")\n[");
    
    for(my $i=0; $i<@numberArray; $i++) 
    {
		print("[",join(",",@{$numberArray[$i]} ),"]");
		print(",") if($i != (@numberArray -1));
	}
	
	print("]\n[");
	
	for(my $i=0; $i<@letterArray; $i++) 
    {
		print("[",join(",",@{$letterArray[$i]} ),"]");
		print(",") if($i != (@letterArray -1));
	}

	print("]\n");
    
}

