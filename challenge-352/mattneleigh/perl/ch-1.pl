#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @word_lists = (
    [ "cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat" ],
    [ "hello", "hell", "world", "wor", "ellow", "elloworld" ],
    [ "a", "aa", "aaa", "aaaa" ],
    [ "flower", "flow", "flight", "fl", "fli", "ig", "ght" ],
    [ "car", "carpet", "carpenter", "pet", "enter", "pen", "pent" ]
);

print("\n");
foreach my $word_list (@word_lists){
    printf(
        "Input: \@words = (%s)\nOutput: (%s)\n\n",
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                @{$word_list}
            )
        ),
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                find_substring_elements(@{$word_list})
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of strings, determine which, if any, are substrings found
# within other strings in the array, not including themselves; if more than one
# instance of a string is present in the array, they WILL count as substrings
# of each other, but that string will still only appear in the returned list
# once
# Takes one argument:
# * The array of strings to examine (e.g. ("cat", "cats", "dog", "dogcat",
#   "dogcat", "rat", "ratcatdogcat") )
# Returns:
# * A list of strings that are substrings of other strings in the supplied
#   array, in the same order such strings appeared within said array (e.g.
#   ("cat", "dog", "dogcat", "rat") )
################################################################################
sub find_substring_elements{

    my @matches;
    my %stored;

    # Compare every element in the array with every
    # other element
    for my $i (0 .. $#ARG){
        for my $j (0 .. $#ARG){
            # Skip ahead to the next $j if we're trying to
            # compare an element with itself
            next
                if($i == $j);

            # See if element $i is contained within element $j
            if($ARG[$j] =~ m/$ARG[$i]/){
                # Determine whether element $i has been stored yet
                unless($stored{$ARG[$i]}){
                    # If not, store it, mark it as stored, and skip
                    # ahead to the next $i
                    push(@matches, $ARG[$i]);
                    $stored{$ARG[$i]} = 1;
                }
                last;
            }
        }
    }

    return(@matches);

}



