#!/usr/env/perl
# Task 1 Challenge 051 Solution by phillip-harris
# 3 Sum
# Given an array @Lof integers. Write a script to find all unique
# triplets such that a + b + c is same as the given target T. Also
# make sure a &lt;= b &lt;= c.
# Here is wiki page for more information.
# Example:
# @L = (-25, -10, -7, -3, 2, 4, 8, 10);
# One such triplet for target 0 i.e. -10 + 2 + 8 = 0.

# I read about the "two pointer trick" and decided to try to implement it
# instead of just brute forcing it.

use strict;

my @L = ( -25, -10, -7, -3, 2, 4, 8, 10 );
my $target = 0;

@L = sort { $a <=> $b } @L;

print "INPUT:\n";
print join ",", @L;
print "\n";

my %triplets;

for ( my $x = 0 ; $x <= $#L ; $x++ ) {
    my $start   = $x + 1;
    my $end     = $#L;
    my $current = $x;

    #print "\n$x\n";
    while ( ( $end - $start ) > 0 ) {
        my $result = $L[$current] + $L[$start] + $L[$end];

#print "\n$current $start $end / $L[$current] + $L[$start] + $L[$end] = $result\n";
        if ( $result == $target ) {

            #print "triplet: $L[$current],$L[$start],$L[$end]\n";
            $triplets{"$L[$current],$L[$start],$L[$end]"} = 1;
            $start++;
            $end--;
        }
        elsif ( $result < $target ) { $start++ }
        else                        { $end-- }
    }
}

print "\nOUTPUT:\n";
print join "\n", keys(%triplets);
