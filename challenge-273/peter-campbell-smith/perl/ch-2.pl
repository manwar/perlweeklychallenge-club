#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-06-10
use utf8;     # Week 273 - task 2 - B after a
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

b_after_a('aabb');
b_after_a('abab');
b_after_a('aaa');
b_after_a('bbb');
b_after_a('ccc');
b_after_a('Write a script to return true if there is at least one b');

sub b_after_a {
	
	my $str = $_[0];
	
	# match a 'b', and then match no 'a' in the rest of the string
	say qq[\nInput:  \$str = '$str'];
	say qq[Output: ] . (($str =~ m|b(.*)| and $1 =~ m|^[^a]*$|) ? 'true' : 'false');
}
