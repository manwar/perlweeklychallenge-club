#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @list_sets = (
    [
        [ "great", "acting" ],
        [ "fine", "drama" ],
        [ [ "great", "fine" ], [ "acting", "drama" ] ]
    ],
    [
        [ "apple", "pie" ],
        [ "banana", "pie" ],
        [ [ "apple", "peach" ], [ "peach", "banana" ] ]
    ],
    [
        [ "perl4", "python" ],
        [ "raku", "python" ],
        [ [ "perl4", "perl5", "raku" ] ]
    ],
    [
        [ "enjoy", "challenge" ],
        [ "love", "weekly", "challenge" ],
        [ [ "enjoy", "love" ] ]
    ],
    [
        [ "fast", "car" ],
        [ "quick", "vehicle" ],
        [ [ "quick", "fast" ], [ "vehicle", "car" ] ]
    ]
);

print("\n");
foreach my $list_set (@list_sets){
    printf(
        "Input: \@list1 = (%s)\n\@list2 = (%s)\n\@list3 = (%s)\n"
        .
        "Output: %s\n\n",
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                @{$list_set->[0]}
            )
        ),
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                @{$list_set->[1]}
            )
        ),
        join(
            ", ",
            map(
                "[ " . join(", ", @{$_}) . " ]",
                @{$list_set->[2]}
            )
        ),
        lists_are_similar(@{$list_set}) ?
            "true"
            :
            "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given two lists of strings and a similarity map, determine whether the two
# lists are similar, according to the following criteria:
# * The two lists must be of the same length
# * All of the corresponding elements within each list (i.e.  those with the
#   same index) must either:
#     - Both appear in the similarity map entry corresponding to that position
#       in the list, if that map entry exists
#     - Be equal to each other if no similarity map entry exists for that
#       position in the list
# Takes three arguments:
# * A ref to the first list of strings to compare (e.g. [ "apple", "pie" ] )
# * A ref to the second list of strings to compare (e.g. [ "banana", "pie" ] )
# * A ref to a similarity map, in which there is a list of similar words that
#   corresponds to each position in the lists to be compared (e.g.
#       [ [ "apple", "peach" ], [ "peach", "banana" ] ]
#   )
# Returns:
# * 0 if the provided lists are not similar (as would be the case in the
#   example above)
# * 1 if the provided lists are similar
################################################################################
sub lists_are_similar{
    my ($list1, $list2, $map) = @_;

    # By definition, if the lists aren't the same
    # length they are not similar
    return(0)
        unless(@{$list1} == @{$list2});

    # Make an array of lookup tables from the
    # similarity map
    my @tables = map(
        {
            my %table = map(
                { $_ => 1 }
                @{$_}
            );

            \%table;
        }
        @{$map}
    );

    # Loop over every element in the lists
    for my $i (0 .. $#$list1){
        # Declare the lists not to be similar unless,
        # for this index, a similarity map entry
        # exists and the words in both lists are in
        # that entry, or a similarity map entry does
        # not exist and the words in both lists are
        # the same
        return(0)
            unless(
                defined($tables[$i]) ?
                    $tables[$i]{$list1->[$i]} && $tables[$i]{$list2->[$i]}
                    :
                    ($list1->[$i] eq $list2->[$i])
            );
    }

    # Got here- the lists must be similar
    return(1);

}



