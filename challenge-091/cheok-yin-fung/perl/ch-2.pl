#!/usr/bin/perl
# The Weekly Challenge 091
# Task 2 Jump Game
use strict;
use warnings;

my @N = @ARGV;
@N = (2,1,2,0,2) if !$ARGV[0];

sub backtrack {
    my @arr = @_;
    my $position = $#arr;
    while ($position > 0) {
        my $index = $position - 1;
        while ($index >= 0) {
            if ($arr[$index] >= $position-$index) {
                $position = $index;
                last;
            } else {
                $index--;
            }
        }
        if ($index < 0) {last;}
    }

    return ($position == 0 ? 1 : 0);                
}   

print join ",", @N;
print "\n";
print backtrack(@N), "\n";


