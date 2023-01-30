#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @numbers = (
    # Additional test cases
    17825,
    33.333,
    ".175",
    -5.43,
    "-.96",

    # Given case- processed last, this time;
    # Happy 200th PWC  :)
    200
);

print("\n");
foreach my $number (@numbers){
    # Join all lines with newlines, concatenate two
    # final newlines, and print the resulting string
    print(
        join(
            "\n",
            @{ number_to_segmented_display($number) }
        )
        .
        "\n\n"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Convert a number to a textual representation of a series or seven-segment
# displays that each have the appropriate segments lit to represent the digits
# in the supplied number
# Takes one argument:
# * The number to represent
# Returns on success:
# * A ref to an array of strings that contain the representation of the
#   seven segment displays; this will consist of five lines of nine characters
#   per digit (but there will be no newline characters)
################################################################################
sub number_to_segmented_display{
    my $number = shift();

    my $lines = [
        "", "", "", "", ""
    ];
    my $neg = 0;

    if($number < 0){
        # The number is negative, make it positive for
        # now, and make a note...
        $neg = 1;
        $number *= -1;
    }

    # Split the number into individual digits and
    # loop over each
    foreach my $digit (split('', $number)){
        if($digit eq "."){
            # This 'digit' was a decimal point
            unless(length($lines->[4])){
                # If there aren't already any digits, add a
                # leading zero
                $lines = digit_to_segments(0);
            }

            # Add the decimal point 'segment' to the last
            # digit
            substr($lines->[4], -2, 1, "o");
        } else{
            # Add the digit's segments to the text
            my $segments = digit_to_segments($digit);

            for my $i (0 .. 4){
                $lines->[$i] .= $segments->[$i];
            }
        }
    }

    if($neg){
        # The original number was negative- prepend a
        # negative sign to our set of lines
        foreach(0 .. $#$lines){
            $lines->[$_] = " " x 9 . $lines->[$_];
        }
        substr($lines->[2], 3, 3, "---");
    }

    return($lines);

}



################################################################################
# Convert a digit to a textual representation of a seven-segment display that
# has the appropriate segments lit to represent the supplied digit
# Takes one argument:
# * The digit to represent
# Returns on success:
# * A ref to an array of strings that contain the representation of the
#   seven segment display; this will consist of five lines of nine characters
#   each (but there will be no newline characters)
# Returns on error:
# * undef if the value passed is not a single positive digit
################################################################################
sub digit_to_segments{
    my $digit = shift();

    return(undef)
        unless($digit =~ m/^\d$/);

    # Segment table:
    #        a
    #       ---
    #   f / g / b
    #     ---
    # e /   / c
    #   ---   o
    #    d
    # NOTE: 'o' shows the intended location of a
    # decimal point, but this code doesn't 'light'
    # that segment- the calling code does, as
    # needed
    my @segment_table = (
        "abcdef",
        "bc",
        "abdeg",
        "abcdg",
        "bcfg",
        "acdfg",
        "acdefg",
        "abc",
        "abcdefg",
        "abcdfg",
    );
    my $text = [
        "         ",
        "         ",
        "         ",
        "         ",
        "         "
    ];

    # Substitute other characters depending on which
    # segments are supposed to be "lit"
    substr($text->[0], 5, 3, "---")
        if($segment_table[$digit] =~ m/a/);
    substr($text->[1], 7, 1, "/")
        if($segment_table[$digit] =~ m/b/);
    substr($text->[3], 5, 1, "/")
        if($segment_table[$digit] =~ m/c/);
    substr($text->[4], 1, 3, "---")
        if($segment_table[$digit] =~ m/d/);
    substr($text->[3], 1, 1, "/")
        if($segment_table[$digit] =~ m/e/);
    substr($text->[1], 3, 1, "/")
        if($segment_table[$digit] =~ m/f/);
    substr($text->[2], 3, 3, "---")
        if($segment_table[$digit] =~ m/g/);

    return($text);

}



