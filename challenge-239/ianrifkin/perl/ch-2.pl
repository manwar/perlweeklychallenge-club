#!/usr/bin/perl
use warnings;
use strict;

# Task 2: Consistent Strings
# You are given an array of strings and allowed string having distinct characters.
# A string is consistent if all characters in the string appear in the string allowed.


# Example 1
my @str = ("ad", "bd", "aaab", "baa", "badab");
my $allowed = "ab";
check_allowed($allowed, \@str);

# Example 2
@str = ("a", "b", "c", "ab", "ac", "bc", "abc");
$allowed = "abc";
check_allowed($allowed, \@str);    

# Example 3
@str = ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d");
$allowed = "cad";
check_allowed($allowed, \@str);

sub check_allowed {
    my ($allowed, $str_ref) = @_;
    my $success_count = 0;

    # Loop through each item in array of strings
    foreach my $str (@$str_ref) {
	# Loop through each character in string to check in allowed list
	my @chars = (split('', $str));
	my $length = scalar @chars;

	for (my $i = 0; $i < $length; $i++) {
	    my $char = $chars[$i];
	    # if character is allowed keep checking or increment success if it's the last in the string
	    if (index($allowed, $char) != -1) {
		$success_count++ if $i == $length - 1;
	    }
	    else {
		last;
	    }
		
	}
    }
    print "$success_count\n";
}

