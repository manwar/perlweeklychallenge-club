#!/usr/bin/env perl

use strict; 

#-- except for the use strict
#-- this uses only perl 4 syntax
#-- as specified in "Programming perl" 1st ed. (the pink camel)
#-- Also only a single variable (symbol table entry) does everything
#-- main::teststring 


{
	local $main'teststring = 'All he could think about was how it would all end. There was still a bit of uncertainty in the equation, but the basics were there for anyone to see. No matter how much he tried to see the positive, it wasn\'t anywhere to be seen. The end was coming and it wasn\'t going to be pretty.';

	&main'teststring($main'teststring);
}

sub teststring {

	local ($main'teststring)=@_;
	

	local @main'teststring = split(/[\.\?\!]\s+/, $main'teststring);
	
	local *teststring = sub {
		local ($main'teststring) = @_;
		sort {uc($a) cmp uc($b)} split /\s+/, $main'teststring;
	};

	
	for $main'teststring (@main'teststring) {
		print ( (join " ", &teststring($main'teststring)),'. ');
	}
	print "\n";

}


