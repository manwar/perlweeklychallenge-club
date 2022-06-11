#!/usr/bin/env perl
use strict;
use warnings;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

# TASK #1 › Fibonacci Words
# Submitted by: Mohammad S Anwar
#
# You are given two strings having same number of digits, $a and $b.
#
# Write a script to generate Fibonacci Words by concatenation of the previous
# two strings. Finally print 51st digit of the first term having at least 51
# digits.
# Example:
#
#     Input: $a = '1234' $b = '5678'
#     Output: 7
#
#     Fibonacci Words:
#
#     '1234'
#     '5678'
#     '12345678'
#     '567812345678'
#     '12345678567812345678'
#     '56781234567812345678567812345678'
#     '1234567856781234567856781234567812345678567812345678'
#
#     The 51st digit in the first term having at least 51 digits
#     '1234567856781234567856781234567812345678567812345678' is 7.

run() unless caller();

sub run() {

    # For the current challenge we start by getting the two input words from the
    # argument list.
    my ( $a, $b ) = @ARGV;

    # Afterwards we ensure both strings have equal lengths. We will not check
    # that both words only contain digits as it doesn't matter for the algorithm
    # wether we restrict the input to be only digits or allow arbitrary
    # characters. (Actually it doesn't even matter that they are of the same
    # length, but I will work with that restriction)
    die "Expect two input words of equal length!\n"
      unless length($a) && length($a) == ( length($b) // 0 );

    # Now we pass both words to the meat of this solution, the `fibonacci_word`
    # routine. We additionaly pass the minimum length of 51 charachters up to
    # which we will build the fibonnaci word
    my $fibonacci_word = fibonacci_word( $a, $b, 51 );

    # Finally we extract the 51st charachter (at index 50) from the build word
    # and print it out as our result.
    my $target = substr( $fibonacci_word, 50, 1 );
    say $target;

}

sub fibonacci_word ( $a, $b, $length ) {

    # The actual fibonacci_word routine cries for a recursive solution. As
    # always with a recursive solution we start with defining the exit
    # condition, which is fullfilled as soon as the $a string reaches at least
    # the requested length $length. In that case $a is the final fibonacci word
    # and we return it to the caller
    return $a if length($a) >= $length;

    # Otherwise we continue the process, by passing $b as the new $a to the
    # fibonacci_word routine and accumulating the next fibonacci word (the
    # concatenation of $a and $b) into $b
    return fibonacci_word( $b, $a . $b, $length );
}
