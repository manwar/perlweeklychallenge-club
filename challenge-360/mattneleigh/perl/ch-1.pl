#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings_and_widths = (
    [ "Hi",    5 ],
    [ "Code", 10 ],
    [ "Hello", 9 ],
    [ "Perl",  4 ],
    [ "A",     7 ],
    [ "",      5 ]
);

print("\n");
foreach my $string_and_width (@strings_and_widths){
    printf(
        "Input: \$str = \"%s\", \$width = %d\nOutput: \"%s\"\n\n",
        $string_and_width->[0],
        $string_and_width->[1],
        center_in_asterisks(@{$string_and_width})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string and a length, pad the string with asterisks (*) on either end
# such that it is centered within a new string of the specified length
# Takes two arguments:
# * The string to pad (e.g. "Hello")
# * The length to which it should be padded (e.g. 9)
# Returns:
# * The provided string, centered within a new string, padded with asterisks to
#   the specified length (e.g. "**Hello**")
################################################################################
sub center_in_asterisks{
    my $string = shift();
    my $length = shift();

    # See how many asterisks we need to add
    $length -= length($string);

    return(
        $length < 1 ?
            # No padding needed
            $string
            :
            $length % 2 ?
                # The remaining width is odd; bias toward the
                # rear of the string
                '*' x ($length = int($length / 2))
                    . $string . '*' x ($length + 1)
                :
                # The remaining width is even
                '*' x ($length /= 2) . $string . '*' x $length
    )

}



