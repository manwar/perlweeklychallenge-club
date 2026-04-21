#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @splitting_tasks = (
    [ "RakuPerl",   4, "*" ],
    [ "Python",     5, "0" ],
    [ "12345",      3, "x" ],
    [ "HelloWorld", 3, "_" ],
    [ "AI",         5, "!" ]
);

print("\n");
foreach my $splitting_task (@splitting_tasks){
    printf(
        "Input: \$str = \"%s\", \$size = %d, \$filler = \"%s\"\n"
        .
        "Output: (%s)\n\n",
        $splitting_task->[0],
        $splitting_task->[1],
        $splitting_task->[2],
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                split_and_pad(@{$splitting_task})
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string, a group length, and a filler character, split the string into
# groups of the specified length; if the final group is shorter than required,
# pad it appropriately with the specified filler character
# Takes three arguments:
# * The string to split (e.g. "HelloWorld")
# * The length that each group taken from the given string should be (e.g. 3)
# * The filler character to be used when padding the last group to the
#   specified length if it doesn't contain enough characters (e.g. '_')
# Returns:
# * A list of string groups of the specified length, the last one having been
#   padded with the filler character if required (e.g. ("Hel", "loW", "orl",
#   "d__") )
################################################################################
sub split_and_pad{
    my ($string, $size, $filler) = @ARG;

    my @groups;

    # Split the string into groups of the
    # specified length
    while(length($string) > $size){
        push(@groups, substr($string, 0, $size, ""));
    }

    # If any characters remain, make them the
    # last group
    push(@groups, $string)
        if(length($string));

    # If the last group is not of the
    # desired lengh, pad it to be so using the
    # specified filler
    $groups[-1] .= $filler x ($size - length($groups[-1]))
        if(length($groups[-1]) < $size);

    return(@groups);

}



