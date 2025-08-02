#!/usr/bin/perl

use strict;
use warnings;

my ($string1, $string2) = (@ARGV);
for my $i (0..length($string1) -2) {
    my $check = $string1;
    my $check2 = substr($check, 0, $i) 
               . substr($check, $i + 1, 1) 
               . substr($check, $i, 1) 
               . substr($check, $i +2);
    if ($check2 eq $string2) {
        exit 0;
    }
}
exit 1;
__END__
TASK #2: Friendly Strings

You are given two strings. Write a script to return true if swapping any 
two letters in one string match the other string, return false otherwise.