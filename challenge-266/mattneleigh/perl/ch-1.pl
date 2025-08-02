#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @line_pairs = (
    [
        "Mango is sweet",
        "Mango is sour"
    ],
    [
        "Mango Mango",
        "Orange"
    ],
    [
        "Mango is Mango",
        "Orange is Orange"
    ]
);

print("\n");
foreach my $line_pair (@line_pairs){
    printf(
        "Input: \$line1 = '%s'\n       \$line2 = '%s'\nOutput: (%s)\n\n",
        $line_pair->[0],
        $line_pair->[1],
        join(
            ", ",
            map(
                "'" . $_ . "'",
                find_uncommon_words(@{$line_pair})
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine which Uncommon Words exist between two sentences; a word is
# considered Uncommon if it appears exactly once in one sentence and doesn't
# appear at all in the other sentence
# Takes two arguments:
# * The first sentence to examine (e.g. "Mango is sweet" )
# * The second sentence to examine (e.g. "Mango is sour" )
# Returns:
# * A list of lower-cased Uncommon Words found among the two sentences (e.g.
#   ("sweet", "sour") ); if no Uncommon Words were found, a single empty string
#   will be returned
################################################################################
sub find_uncommon_words{

    my $word;
    my %frequency1;
    my %frequency2;
    my @uncommons;

    # Build frequency tables for each sentence,
    # counting unique words in each, without regard to
    # letter case
    foreach $word (split(/ /, $ARG[0])){
        $frequency1{lc($word)}++;
    }
    foreach $word (split(/ /, $ARG[1])){
        $frequency2{lc($word)}++;
    }

    # Determine which words had appeared once in their
    # respective sentence but not at all in the other,
    # and store them in a list for Uncommons
    foreach $word (keys(%frequency1)){
        push(@uncommons, $word)
            if(($frequency1{$word} == 1) && !$frequency2{$word});
    }
    foreach $word (keys(%frequency2)){
        push(@uncommons, $word)
            if(($frequency2{$word} == 1) && !$frequency1{$word});
    }

    # If there were Uncommon Words, return the list
    # thereof; if not, return the empty string
    return(
        @uncommons ?
            @uncommons
            :
            ""
    );

}



