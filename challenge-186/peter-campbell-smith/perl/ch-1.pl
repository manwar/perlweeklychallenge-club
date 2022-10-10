#!/usr/bin/perl

# Peter Campbell Smith - 2022-10-10
# PWC 186 task 1

use v5.28;
use utf8;
use warnings;
binmode(STDOUT, ':utf8');

# You are given two list @a and @b of same size. Create a subroutine sub zip(@a, @b) 
# that merges the two lists - eg 1,2,3 + a,b,c = 1,a,2,b,3,c.

# Blog: https://pjcs-pwc.blogspot.com/2022/10/merge-like-zip-and-unidecode.html

my (@tests, $test, @one, @two, @three, $j, $ntests);

@tests = ([1, 2, 3], ['a', 'b', 'c'], 
	['c', 'r', 'e', 't', 'a', 's', 'e'], ['o', 'r', 'c', ' ', 'n', 'w', 'r']);

# loop over tests
$ntests = scalar @tests / 2;
for $j (1 .. $ntests) {
	@one = @{shift @tests};
	@two = @{shift @tests};
	
	# zip and print out
	@three = zip(@one, @two);
	say qq[\nInput:  (] . join(',', @one) . qq[),(] . join(',', @two) . qq[)];
	say qq[Output: (] . join(',', @three)  . ')';
}

sub zip {
	
	my (@result, @one, @two, $j, $length);
	$length = scalar @_ / 2;
	
	# push items in sequence (note that $_ and $_[] 
	push @result, $_[$_], $_[$_ + $length] for 0 .. $length - 1;
	return @result;
}
