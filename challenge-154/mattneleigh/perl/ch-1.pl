#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $string = "PERL";
my @given_permutations = qw(
    PELR PREL PERL PRLE PLER PLRE EPRL EPLR ERPL
    ERLP ELPR ELRP RPEL RPLE REPL RELP RLPE RLEP
    LPER LPRE LEPR LRPE LREP
);

printf(
    "\nGiven permutations: %s\n",
    join(", ", sort(@given_permutations))
);
printf(
    "Permutations not found in the list: %s\n\n",
    join(", ", find_missing_permutations($string, \@given_permutations)),
);

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################


################################################################################
# Determine which possible sequences may be missing from a set of permutations
# of characters
# Takes two arguments:
# * A (hopefully short...) string of characters from which the permutations
#   will be constructed (e.g. "PERL")
# * A ref to a list of preexisting permutations, which must consist of strings
#   made up of EXACTLY the characters found in the first argument (e.g.
#   [ "PERL", "PREL", "ERPL", "PLER" ... ] )
# Returns:
# * A list of possible permutations of the characters in the first argument
#   that were NOT found in the array pointed to by the second argument; If
#   there are none, this list will be empty
# NOTE: Permutation sequence derived from the QuickPerm algorithm as found at:
# https://www.baeldung.com/cs/array-generate-all-permutations
# https://www.quickperm.org/01example.php
################################################################################
sub find_missing_permutations{
    my $chars_joined = shift();
    my $given_list = shift();

    my %given_table;
    my @chars = split('', $chars_joined);
    my @p = (0 .. scalar(@chars));
    my @missing_list;
    my $i;
    my $j;

    # Build a lookup table for the given list
    # of known permutations
    foreach(@{$given_list}){
        $given_table{$ARG} = 1;
    }

    # See if the initial arrangement is in
    # the given list
    push(@missing_list, $chars_joined)
        unless($given_table{$chars_joined});

    # Generate permutations...
    $i = 1;
    while($i < scalar(@chars)){
        $p[$i]--;
        if($i % 2){
            # $i is odd
            $j = $p[$i];
        } else{
            # $i is even
            $j = 0;
        }

        # Swap the characters at $i and $j
        ($chars[$j], $chars[$i]) = ($chars[$i], $chars[$j]);

        # See if this permutation wasn't in the
        # given list
        $chars_joined = join("", @chars);
        push(@missing_list, $chars_joined)
            unless($given_table{$chars_joined});

        $i = 1;
        while($p[$i] == 0){
            $p[$i] = $i;
            $i++;
        }
    }

    # Hand the caller a sorted list of
    # missing permutations
    return(sort(@missing_list));

}



