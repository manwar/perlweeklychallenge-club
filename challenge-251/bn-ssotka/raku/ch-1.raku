#!/usr/bin/env raku

# Write a script to find the concatenation value of the given array.

# The concatenation of two numbers is the number formed by concatenating their numerals.

# For example, the concatenation of 10, 21 is 1021.
# The concatenation value of @ints is initially equal to 0.
# Perform this operation until @ints becomes empty:

# If there exists more than one number in @ints, pick the first element
# and last element in @ints respectively and add the value of their
# concatenation to the concatenation value of @ints, then delete the
# first and last element from @ints.

# If one element exists, add its value to the concatenation value of
# @ints, then delete it.

sub concat (@ints) {
    say "Got ",@ints;
    return 0 unless @ints;
    return @ints[0] if @ints == 1;
    return (@ints[0].Str ~ @ints[*-1].Str).Int + concat(@ints[1..*-2]);
}

multi MAIN (*@ints){
    say concat(@ints);
}
multi MAIN {
    my @tests = ((6, 12, 25, 1),
                 (10, 7, 31, 5, 2, 2),
                 (1, 2, 10));
    for @tests -> @t {
        say concat(@t);
    }
}