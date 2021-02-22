=begin

TASK #1 › Pattern Match
Submitted by: Mohammad S Anwar
You are given a string $S and a pattern $P.

Write a script to check if given pattern validate the entire string. Print 1 if pass otherwise 0.

The patterns can also have the following characters:

? - Match any single character.
* - Match any sequence of characters.
    Example 1:
        Input: $S = "abcde" $P = "a*e"
        Output: 1
    Example 2:
        Input: $S = "abcde" $P = "a*d"
        Output: 0
    Example 3:
        Input: $S = "abcde" $P = "?b*d"
        Output: 0
    Example 4:
        Input: $S = "abcde" $P = "a*c?e"
        Output: 1

=end
=cut


use strict;
use warnings;
use Data::Dumper;

#Input
my $S = "abcde";
my $P = "a*e";


my @pattern = split //, $P; 

replaceCharacter();

sub replaceCharacter {
    foreach ( @pattern ) {  
        if ($_ eq '?') {
            $_ = '.';
        }
        elsif ($_ eq '*') {
            $_ = '.+';
        }
    } 
    my $redex = join '', @pattern;
    printResult($redex);
}

sub printResult{
    my $redex = shift;
    if ($S =~ /^$redex$/){
        print "1\n";
    }
    else {
        print "0\n";
    }
}
