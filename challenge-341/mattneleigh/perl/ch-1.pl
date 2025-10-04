#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @keyboard_data_sets = (
    [
        "Hello World",
        [ "d" ]
    ],
    [
        "apple banana cherry",
        [ "a", "e" ]
    ],
    [
        "Coding is fun",
        [ ]
    ],
    [
        "The Weekly Challenge",
        [ "a","b" ]
    ],
    [
        "Perl and Python",
        [ "p" ]
    ]
);

print("\n");
foreach my $keyboard_data (@keyboard_data_sets){
    printf(
        "Input: \$str = '%s', \@keys = (%s)\nOutput: %d\n\n",
        $keyboard_data->[0],
        join(
            ", ",
            @{$keyboard_data->[1]}
        ),
        count_typeable_words($keyboard_data)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Count the words in a string that can be typed with a keyboard that has a
# specified set of broken letter keys
# Takes one argument:
# * A ref to an array that contains the string to examine, and a list of
#   broken letter keys (e.g. [ "apple banana cherry", [ "a", "e" ] ] )
# Returns:
# * The number of words in the string that can be typed without using the
#   broken keys (e.g. 0 )
# Note that the examination process is not case-sensitive
################################################################################
sub count_typeable_words{
    my @words = split(/ /, $ARG[0][0]);

    # If no keys are broken, all words can be
    # typed
    return(scalar(@words))
        unless(scalar(@{$ARG[0][1]}));

    # Set up and precompile a regex with a
    # character class that includes the broken
    # keys
    my $broken = "[" . join("", @{$ARG[0][1]}) . "]";
    $broken = qr/$broken/i;

    my $count = 0;
    my $word;

    # Loop over each word and count the words
    # that do NOT include the broken keys
    foreach $word (@words){
        $count++
            unless($word =~ m/$broken/);
    }

    return($count);

}



