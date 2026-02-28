#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 6, 7, 8, 9, 10 ],
    [ -3, 0, 1000, 99 ],
    [ 1, 2, 3, 4, 5 ],
    [ 0, -1, -2, -3, -4 ],
    [ 100, 101, 102 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: (%s)\nOutput: (%s)\n\n",
        join(", ", @{$integer_list}),
        join(", ", linguistic_sort(@{$integer_list}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of integers, which may be positive or negative, sort them in
# lexicographical order according to their representation in the English
# language (i.e. 5 is represented as "five," -2043 is represented as "negative
# two thousand forty three," etc.)
# Takes one argument:
# * The array of integers to sort in order of their written English
#   representation (e.g. (-3, 0, 1000, 99) )
# Returns:
# * The integers, sorted as described above (e.g. (-3, 99, 1000, 0) => (
#   "negative three", "ninety nine", "one thousand", "zero")
################################################################################
sub linguistic_sort{

    my @ones = (
        "", "one", "two", "three", "four", "five", "six", "seven", "eight",
        "nine"
    );
    my @tens = (
        "", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy",
        "eighty", "ninety"
    );
    my @teens = (
        "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen",
        "sixteen", "seventeen", "eighteen", "ninteen"
    );
    my @magnitudes = (
        "", "thou", "mill", "bill", "tril", "quad", "quin", "sext", "sept"
    );

    return(
        # 4) Extract the original values, now sorted
        map(
            $_->[1],
            # 3) Sort the array from (2) based on the
            # lexicographical order of the text
            # representations of the ints' values
            sort(
                { $a->[0] cmp $b->[0]; }
                # 2) Build an array of text representations
                # of the provided ints and their original
                # values
                map(
                    [
                        # 1) Convert each int to its English
                        # representation
                        _num_to_string(
                            $_, \@ones, \@tens, \@teens, \@magnitudes
                        ),
                        $_
                    ],
                    @ARG
                )
            )
        )
    );

}



################################################################################
# Provide a text representation of an integer in English, for sorting purposes;
# note that the provided string will lack spaces, and certain words may be
# truncated to the minimum length required to facilitate unambiguous sorting
# order
# Takes five arguments:
# * The integer to process, which may be positive or negative (e.g. 312000530)
# * The next four arguments are refs to the following arrays:
#     * an array of strings to use to describe digits in Ones Place(s)
#     * an array of strings to use to describe digits in Tens Place(s)
#     * an array of special strings to use to describe eleven through the teens
#     * an array of strings to use to describe orders of magnitude for each
#       block of three digits
# Returns:
# * A sortable string representation of the provided integer, constructed using
#   the provided string fragments (e.g. "threehuntwelvemillfivehunthirty")
# NOTE: This function should ONLY be called by linguistic_sort() as it is
# configured to provide compatible string arrays
################################################################################
sub _num_to_string{
    my $number = shift();
    my ($ones, $tens, $teens, $magnitudes) = @ARG;

    my $negative = "";
    my @blocks;
    my $magnitude = 0;
    my $digit;

    # Check for negativity
    if($number < 0){
        $negative = "neg";
        $number =~ s/-//;
    }

    # Split the number into blocks of three
    # digits, starting from the least-significant
    while($number =~ s/(.{1,3})$//){
        push(@blocks, $1);
    }

    # Loop over each block of digits
    foreach my $block (@blocks){
        my @digits = split("", $block);

        # Loop over each digit in this block
        $block = "";
        while(@digits){
            if($#digits == 2){
                # The first digit is in the Hundreds Place
                if($digits[0]){
                    $block = $ones->[$digits[0]] . "hun";
                } else{
                    $block = "";
                }
                shift(@digits);
            } elsif($#digits == 1){
                # The first digit is in the Tens Place
                if($digits[0] == 1){
                    # Special case for the tens place- we will
                    # consume the ones-place digit too
                    shift(@digits);
                    $block .= $teens->[$digits[0]];
                } else{
                    # Conventional case for the Tens Place
                    $block .= $tens->[$digits[0]];
                }
                shift(@digits)
            } elsif($#digits == 0){
                # The first digit is in the Ones Place
                $block .= $ones->[shift(@digits)];
            }
        }

        # If there were nonzero digits recorded in
        # this block, add a magnitude marker (which
        # may be blank)
        $block .= $magnitudes->[$magnitude]
            if($block ne "");
        $magnitude++;
    }

    # Switch the blocks back to conventional
    # order, combine them, and add a negative
    # marker if one had been set up
    $number = $negative . join("", reverse(@blocks));

    return($number eq "" ? "zero" : $number);

}



