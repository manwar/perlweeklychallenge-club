#!/usr/env perl
# Perl Challenge 043 Task 2
# Write a script to generate Self-descriptive Numbers in a given base.
# In mathematics, a self-descriptive number is an integer m that in a
# given base b is b digits long in which each digit d at position n
# (the most significant digit being at position 0 and the least
# significant at position b - 1) counts how many instances of digit
# n are in m.
use strict; use warnings;

# sets up array to simplify conversions of decimal to  baseN
my @decToBase=(0..9,"A".."Z","?");

printf ("%-4s %-36s %-36s\n","base", "Derived","Cheating" );
foreach (4,5,7..36){
    printf ("%4s %-36s %-36s\n",$_, getSelfDescriptive($_),cheatGetSelfDescriptive($_) );
}

# This method uses description that the count of instances of digit N is 
# in position N.  It uses a test that works by placing counts of digits for 
# a starting number in respective positions, and keeps doing so until
# there is no more change. Assumes no prior knowledge of these numbers 

sub getSelfDescriptive{
	my $base=shift;
	
	#starts with a string of 0s of length $base
	#can be any number...the algorithm converges rapidly
	my $start= "0"x $base;  
	my $end=""; my $count=0;
	
	# keep updating until stabilises with the self-descriptive number
	while ($end ne $start){
		# for numbers that do not converge, a little bit of nudging
		# by inserting a random digit in a random positions may help
		if ($count++>5){   
		  substr($start,rand()*$base,1)=$decToBase[rand()*$base];
		  $count=0
	    }
		$end=$start;
		$start=countAndPlace($end);
		
	}
    return $start;
    
    # a single pass that counts occurences and puts that count in
    # the respective positions within that string
	sub countAndPlace{
		my ($string)=@_;
		my @split=split  //,$string;
		foreach my $pos (0..$#split){
			$split[$pos]= $decToBase[ grep { $_ eq  $decToBase[$pos] } @split];
		}
		return join "",@split;
	}
}

# this method recognises that there is an obvious, observable pattern of
# self-descriptive numbers....does not work for 4 and 5
sub cheatGetSelfDescriptive{
	my $base=shift;
	return  $decToBase[$base-4]."21".("0"x($base-7))."1000" if $base >6;
	return "oops...failed!"
}
