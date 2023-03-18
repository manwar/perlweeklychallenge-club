#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @list_pairs = (
    [
        [ "Perl", "Raku", "Love" ],
        [ "Raku", "Perl", "Hate" ]
    ],
    [
        [ "A", "B", "C" ],
        [ "D", "E", "F" ]
    ],
    [
        [ "A", "B", "C" ],
        [ "C", "A", "B" ]
    ]
);

print("\n");
foreach my $list_pair (@list_pairs){
    printf(
        "Input: \@list1 = (%s)\n       \@list2 = (%s)\nOutput: (%s)\n\n",
        list_to_quoted_string(@{$list_pair->[0]}),
        list_to_quoted_string(@{$list_pair->[1]}),
        list_to_quoted_string(
            common_minimum_index_sum($list_pair->[0], $list_pair->[1])
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Find the matching string(s) between two lists of strings, which also have the
# minimum sum of their respective indices within each list
# Takes two arguments:
# * A ref to the first list of strings to examine
# * A ref to the second list of strings to examine
# Returns:
# * A list of matches among the two lists that have the minimum sum of their
#   respective indices within the original lists; this list will be empty if no
#   matches are found, or may have multiple members if multiple matches are
#   tied for the lowest index sum; the sum itself is not reported
################################################################################
sub common_minimum_index_sum{
    my $list1 = shift();
    my $list2 = shift();

    my @matches = ();

    # Compare each member of the first
    # list with each member of the second,
    # and store each match along with the
    # sum of the matching members' indices
    for my $i (0 .. $#$list1){
        for my $j (0 .. $#$list2){
            if($list1->[$i] eq $list2->[$j]){
                push(@matches, [ $list1->[$i], $i + $j ]);
            }
        }
    }

    if(scalar(@matches)){
        my $index_sum;

        # There were matches; sort them in
        # ascending order by their index sums
        @matches = sort({ $a->[1] <=> $b->[1] } @matches);

        # Store the first (lowest) index sum
        # and simplifiy the first member of
        # the match list
        $index_sum = $matches[0][1];
        $matches[0] = $matches[0][0];

        # Compare the first sum with
        # subsequent sums
        for my $i (1 .. $#matches){
            if($matches[$i][1] == $index_sum){
                # The sum matched- simplify this
                # member of the match list
                $matches[$i] = $matches[$i][0];
            } else{
                # It didn't match- delete this and
                # all subsequent matches, and break
                # out of the loop
                splice(@matches, $i);
                last;
            }
        }
    }

    return(@matches);

}



################################################################################
# Build a quoted, comma-separated string out of the contents of a list
# Takes one argument:
# * The list (e.g. ( 1, 2, 3, 4 )
# Returns:
# * A quoted, comma-separated string containing the contents of the list (e.g.
#   ""1", "2", "3", "4"")
################################################################################
sub list_to_quoted_string{

    return(
        # (2) Join the quoted strings together
        # with commas
        join(
            ", ",
            # (1) Put quotes around each list member
            map(
                "\"".$_."\"",
                @ARG
            )
        )
    );

}



