#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @string_sets = (
    [
        [ "Perl", "is", "my", "friend" ],
        [ "Perl", "and", "Raku", "are", "friend" ]
    ],
    [
        [ "Perl", "and", "Python", "are", "very", "similar" ],
        [ "Python", "is", "top", "in", "guest", "languages" ]
    ],
    [
        [ "Perl", "is", "imperative", "Lisp", "is", "functional" ],
        [ "Crystal", "is", "similar", "to", "Ruby" ]
    ]
);

print("\n");
foreach my $string_set (@string_sets){
    printf(
        "Input: \@words1 = (%s)\n       \@words2 = (%s)\nOutput: %d\n\n",
        join(
            ", ",
            map("\"" . $_ . "\"", @{$string_set->[0]})
        ),
        join(
            ", ",
            map("\"" . $_ . "\"", @{$string_set->[1]})
        ),
        count_mutual_singles($string_set)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given two or more arrays of strings, count the number of words that appear in
# all of these arrays but only once each
# Takes one argument:
# * A ref to an array of arrays of strings (e.g.
#       [
#           [ "Perl", "and", "Python", "are", "very", "similar" ],
#           [ "Python", "is", "top", "in", "guest", "languages" ]
#       ]
#   )
# Returns:
# * The number of words that appear in all of the supplied arrays but only once
#   each (e.g. 1 )
################################################################################
sub count_mutual_singles{

    my @singles_tables;
    my $single_count = 0;

    # Loop over each list of strings
    foreach my $string_list (@{$ARG[0]}){
        my $string;
        my $singles_table = {};

        # Set up a table of the counts of instances of
        # each string
        foreach $string (@{$string_list}){
            $singles_table->{$string}++;
        }

        # Strip out any strings that showed up more than
        # once
        foreach $string (keys(%{$singles_table})){
            delete($singles_table->{$string})
                if($singles_table->{$string} > 1);
        }

        # Store the table of singles from this list of
        # strings
        push(@singles_tables, $singles_table);
    }

    # Loop over every remaining string in the
    # first table of single words
    foreach my $string (keys(%{$singles_tables[0]})){
        my $missing = 0;

        # Loop over all subsequent tables
        for my $i (1 .. $#singles_tables){
            # Mark this word as missing and break out of the
            # loop if it is not found in this table
            unless($singles_tables[$i]->{$string}){
                $missing = 1;
                last;
            }
        }

        # Increment the singles count unless this string
        # was marked as missing
        $single_count++
            unless($missing);

    }

    return($single_count);

}



