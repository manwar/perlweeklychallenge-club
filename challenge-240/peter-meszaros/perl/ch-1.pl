#!/usr/bin/env perl
#
# You are given two arrays of strings and a check string.
# 
# Write a script to find out if the check string is the acronym of the words in
# the given array.
# Example 1
# 
# Input: @str = ("Perl", "Python", "Pascal")
#        $chk = "ppp"
# Output: true
# 
# Example 2
# 
# Input: @str = ("Perl", "Raku")
#        $chk = "rp"
# Output: false
# 
# Example 3
# 
# Input: @str = ("Oracle", "Awk", "C")
#        $chk = "oac"
# Output: true
# 

use strict;
use warnings;
use feature qw/fc/;
use Test::More;
use Data::Dumper;

my $cases = [
	[["Perl", "Python", "Pascal"], "ppp"],
	[["Perl", "Raku"], "rp"],
	[["Oracle", "Awk", "C"], "oac"],
];

sub acronym
{
	my ($l, $chk) = @{$_[0]};

	my @chk = split('', $chk);
	for my $str (@$l) {
		return 0 if fc(substr($str, 0, 1)) ne fc(shift @chk);
	}
    return 1;
}

is(acronym($cases->[0]), 1, '[["Perl", "Python", "Pascal"], "ppp"]');
is(acronym($cases->[1]), 0, '[["Perl", "Raku"], "rp"]');
is(acronym($cases->[2]), 1, '[["Oracle", "Awk", "C"], "oac"]');
done_testing();

exit 0;


