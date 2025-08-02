#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @word_lists = (
    [ "ab", "de", "ed", "bc" ],
    [ "aa", "ba", "cd", "ed" ],
    [ "uv", "qp", "st", "vu", "mn", "pq" ]
);

print("\n");
foreach my $word_list (@word_lists){
    printf(
        "Input: \@words = (%s)\nOutput:  %d\n\n",
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                @{$word_list}
            )
        ),
        count_reversed_pairs(@{$word_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of distinct words, count the number of reversed pairs in the
# list- that is to say, the pairs of strings in which one string is the reverse
# of the other
# Takes one argument:
# * The list of words to examine (e.g. ( "uv", "qp", "st", "vu", "mn", "pq" ) )
# Returns:
# * The count of reversed pairs (e.g. 2 )
################################################################################
sub count_reversed_pairs{

    my $pairs = 0;
    my @reversed;
    my $j;

    # Store reversed copies of every word that $j
    # will refer to later in the nested loop below
    for $j (1 .. $#ARG){
        $reversed[$j] = join("", reverse(split("", $ARG[$j])));
    }

    # Compare every original string with every
    # reversed equivalent
    for my $i (0 .. $#ARG - 1){
        for $j ($i + 1 .. $#ARG){
            # Increment the counter if the string at $i
            # matches the reversed string at $j
            $pairs++
                if($ARG[$i] eq $reversed[$j]);
        }
    }

    return($pairs);

}



