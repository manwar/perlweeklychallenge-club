#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @ranking_data_sets = (
    [
        [ 'perl', 'c', 'python' ],
        [ 2, 1, 3 ]
    ],
    [
        [ 'c++', 'haskell', 'java' ],
        [ 1, 3, 2 ]
    ]
);

print("\n");
foreach my $ranking_data (@ranking_data_sets){
    printf(
        "Input: \@lang = (%s)\n       \@popularity = (%s)\nOutput: (%s)\n\n",
        join(
            ", ",
            map(
                "'" . $_ . "'",
                @{$ranking_data->[0]}
            )
        ),
        join(", ", @{$ranking_data->[1]}),
        join(
            ", ",
            map(
                "'" . $_ . "'",
                sort_languages_by_popularity($ranking_data)
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Sort a list of languages by their popularity rankings
# Takes one argument:
# * A set of language rankings in the form of a ref to an array that contains
#   a list of language names and a list of their respective popularity rankings
#   (e.g.
#       [
#           [ "c++", "haskell", "java" ],
#           [ 1, 3, 2 ]
#       ]
#   )
# Returns:
# * A list of language names sorted by their popularity (e.g.
#   ( "c++", "java", "haskell" ) )
################################################################################
sub sort_languages_by_popularity{

    return(
        # 2: Create an array slice consisting of
        # the language names, sorted in the order
        # defined by the rankings
        @{$ARG[0][0]}[
            # 1: Create a set of array indices based on
            # the language rankings sorted in ascending
            # order
            sort(
                { $ARG[0][1][$a] <=> $ARG[0][1][$b] }
                0 .. $#{$ARG[0][0]}
            )
        ]
    );

}



