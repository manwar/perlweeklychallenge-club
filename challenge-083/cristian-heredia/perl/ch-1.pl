=begin
TASK #1 › Words Length
Submitted by: Mohammad S Anwar
You are given a string $S with 3 or more words.

Write a script to find the length of the string except the first and last words ignoring whitespace.

Example 1:
Input: $S = "The Weekly Challenge"

Output: 6
Example 2:
Input: $S = "The purpose of our lives is to be happy"

Output: 23
=end
=cut

use strict;
use warnings;
use Data::Dumper;

#Variables
my $S = "The purpose of our lives is to be happy";
my $count = 0;
my @array;

convert2Array();

sub convert2Array {
    @array = split / /, $S;
    removeFirstLast();
}

sub  removeFirstLast {
    
    shift @array;
    pop @array;
    lengthString();
}

sub lengthString {
        
        foreach (my $i=0; $i<@array; $i++) {
            $count = $count + length $array[$i];
        }
        print "Outout: $count \n";
    
}

