#!env raku


# Perl Weekly Challenge 50
# see <https://perlweeklychallenge.org/blog/perl-weekly-challenge-051/>
#
# Task 2
# Write a script to display all Colorful Number with 3 digits.
# A number can be declare Colorful Number where all
# the products of consecutive subsets of digit are different.
# For example, 263 is a Colorful Number since 2, 6, 3, 2x6, 6x3, 2x6x3 are unique.


# A function to test if the specified number
# is colorful.
sub is-colorful( Int:D $number ) {
    my @digits   = "%03d".sprintf( $number ).split( '', :skip-empty );

    # short-circuit: if the three numbers are the same,
    # than it is not colorful
    return False if [==] @digits;

    # stores the products into an hash to count
    # how many times it appear
    my %products;


    # products of all sequences, use range and reduction operator
    for 0 ..^ @digits.elems  {
        # skip single element arrays
        next if $_ == @digits.elems - 1;
        %products{ [*] @digits[ $_ ..^ @digits.elems ] }++;
    }

    # NOT CLEAR: are the single digits to be included?
    # suppose they are
    %products{ $_ }++ for @digits;

    return False if %products.values.grep: * > 1;
    return True;
}


sub MAIN( Int :$digits? = 3 ) {

    # create the sequence of numbers to test
    my @numbers = 1 .. 9 x $digits;

    # check for every number if it is colorful
    $_.say if is-colorful( $_ ) for @numbers;

}
