#!env raku
#
# Perl Weekly Challenge 50
# see
# <https://perlweeklychallenge.org/blog/perl-weekly-challenge-050/>
#
# Task 2
# Noble Integer
#
# You are given a list, @L, of three or more random integers between 1 and 50.
# A Noble Integer is an integer N in @L, such that there are exactly N integers greater
# than N in @L.
# Output any Noble Integer found in @L, or an empty list if none were found.
#
# An interesting question is whether or not there can be multiple Noble Integers in a list.
# For example,
#
# Suppose we have list of 4 integers [2, 6, 1, 3].
# Here we have 2 in the above list, known as Noble Integer,
# since there are exactly 2 integers in the list i.e.3 and 6, which are greater than 2.
# Therefore the script would print 2.


sub MAIN( Int :$how-many where { $how-many >= 3 } = 3  ) {
    my @L = (1..50).List.pick: $how-many;

    # first approach: use a grep to count how
    # many elemnts are there
    my @nobel;
    for @L -> $a {
        @nobel.push( $a ) if @L.grep( { $a < $_  } ).elems == $a;
    }

    # second approach: sort the list, then
    # seek for every element that must have exactly
    # its value of numbers higher than it
    @L .= sort;
    for 0 .. @L.elems - 1 {
        @nobel.push( @L[ $_ ] ) if @L[ $_ ] == @L.elems - $_;
    }

    say @nobel;
}
