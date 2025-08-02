#!/usr/bin/perl
use strict;
use warnings;
#-------------------------------------------
sub line_counts {

    my ($str, @widths) = @_;
    my ($max_width_line, $width_line, $no_lines) = (100, 0, 1);

    # process each character in the given string $str
    foreach ( split(//, $str) ) {

        # increment $width_line with the width value of the current character $char: see above
        if ( ($width_line + $widths[(ord($_) - 97)]) <= $max_width_line) {

            $width_line += $widths[(ord($_) - 97)];

        }
        else {
            # a new line
            $no_lines++;
            # starting with the width value of the current character
            $width_line = $widths[(ord($_) - 97)];
        }
    }
    print("($no_lines, $width_line)\n");
}

# TESTS

my $str;
my @widths = ();

# Example 1
$str = "abcdefghijklmnopqrstuvwxyz";
@widths = (10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10);
line_counts($str, @widths); # Output: (3, 60)

# Example 2
$str = "bbbcccdddaaa";
@widths = (4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10);
line_counts($str, @widths); # Output: (2, 4)
