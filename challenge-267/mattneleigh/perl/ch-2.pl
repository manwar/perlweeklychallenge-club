#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @text_definitions = (
    [
        "abcdefghijklmnopqrstuvwxyz",
        [
            10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
            10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
            10, 10, 10, 10, 10, 10
        ]
    ],
    [
        "bbbcccdddaaa",
        [
             4, 10, 10, 10, 10, 10, 10, 10, 10, 10,
            10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
            10, 10, 10, 10, 10, 10
        ]
    ]
);

print("\n");
foreach my $text_definition (@text_definitions){
    printf(
        "Input: \$str = \"%s\"\n       \@widths = (%s)\nOutput: (%s)\n\n",
        $text_definition->[0],
        join(", ", @{$text_definition->[1]}),
        join(", ", count_displayed_lines($text_definition))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string of text and a table of letter widths, in pixels, determine
# how many lines of text would be required to display the string, and how many
# pixels are required to display the last line
# Takes one argument:
# * A ref to an array that contains the string to examine and a table of 26
#   letter widths, in pixels, representing characters a-z (e.g.
#      [
#          "abcdefghijklmnopqrstuvwxyz",
#          [
#              10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
#              10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
#              10, 10, 10, 10, 10, 10
#          ]
#      ]
#   )
# Returns:
# * A list containing the number of lines required to display the provided
#   text, and the number of pixels required to display the last line (e.g.
#   ( 3, 60 ) )
################################################################################
sub count_displayed_lines{

    my $line_width = 0;
    my $lines = 1;

    # An edge case- if the string is zero length,
    # there will be no lines and zero pixels
    return(0, 0)
        unless(length($ARG[0][0]));

    # Loop over each character
    foreach my $char (split("", $ARG[0][0])){
        # Get the character's widgh from the table
        # using its ordinal position relative to 'a'
        my $char_width = $ARG[0][1][ord(lc($char)) - 97];

        if(($line_width + $char_width) > 100){
            # This character won't fit on the line-
            # increment line count and reset line width to
            # the character's width
            $lines++;
            $line_width = $char_width;
        } else{
            # This character fits on the line- add its
            # width
            $line_width += $char_width;
        }
    }

    return($lines, $line_width);

}



