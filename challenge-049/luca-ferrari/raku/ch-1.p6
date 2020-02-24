#!env raku
#
# Perl Weekly Challenge 49
# see <https://perlweeklychallenge.org/blog/perl-weekly-challenge-049/>
#
# Task 1
# Smallest Multiple
#
# Write a script to accept a positive number as command line argument
# and print the smallest multiple of the given number consists of digits 0 and 1.
#
# For example:
# For given number 55, the smallest multiple is 110 consisting of digits 0 and 1.


sub MAIN( Int :$number! where { $number > 0 } ) {
    "Minor multiple of $number made up by 0 and 1 only is { $number * $_ }".say && exit if ( $number * $_ ) ~~ / ^ <[01]>+ $ /
    for 2 .. Inf;
}
