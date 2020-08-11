#!/usr/env perl
# challenge 38
# date extractor

use strict;
use warnings;
use feature 'say';
use Time::Local;
# Uses a Time::Local
# Validates that this is a seven digit input
# at the same time splitting the input into into sperate segments
# reconstructs the segmenst as a new date using timelocal...
# timelocal usefully also validates the date for us
# an eval is used to prevent the croak on invalid date entry so
# multiple inputs can be tested 

foreach (1240229,"elephant",1234567,1111111,2222222,3333333){ 
	say $_,"  ",extractDate($_);
}

sub extractDate{
     if (shift=~/^(1|2)(\d{2})(\d{2})(\d{2})$/ ){
		 if (eval{timelocal( 0, 0, 0, $4, $3-1, ($1==1?19:20).$2)}){
			 return "".($1==1?19:20).$2."-$3-$4" 
		 }
		 else {
			 return "Invalid Date"
		 }
		 
	 }
	 else {
		 return "Must be seven digits starting with 1 or 2 "
	 }
}
 
     
    
