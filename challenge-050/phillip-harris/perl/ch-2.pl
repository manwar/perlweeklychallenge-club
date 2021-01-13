#!/usr/env/perl
# Task 2 Challenge 050 Solution by phillip-harris
# Contributed by Ryan Thompson.Noble Integer
# You are given a list, @L, of three or more random integers between
# 1 and 50. A Noble Integer is an integer N in @L, such that there
# are exactly N integers greater than N in @L. Output any Noble
# Integer found in @L, or an empty list if none were found.
# An interesting question is whether or not there can be multiple
# Noble Integers in a list.
# For example,
# Suppose we have list of 4 integers [2, 6, 1, 3].
# Here we have 2 in the above list, known as Noble Integer, since
# there are exactly 2 integers in the list i.e.3 and 6, which are
# greater than 2.
# Therefore the script would print 2.

@L = sort { $a <=> $b } ( 2, 6, 1, 3 );
for ( $pos = 0 ; $pos <= $#L ; $pos++ ) {
    if ( $L[$pos] == $#L - $pos ) {
        print $L[$pos] . "\n";
    }
}

