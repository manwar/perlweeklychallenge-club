#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @matrices = (
    [
        [ 0, 0, 0, 0, 1, 0 ],  # 0 knows 4
        [ 0, 0, 0, 0, 1, 0 ],  # 1 knows 4
        [ 0, 0, 0, 0, 1, 0 ],  # 2 knows 4
        [ 0, 0, 0, 0, 1, 0 ],  # 3 knows 4
        [ 0, 0, 0, 0, 0, 0 ],  # 4 knows NOBODY
        [ 0, 0, 0, 0, 1, 0 ],  # 5 knows 4
    ],
    [
        [ 0, 1, 0, 0 ],  # 0 knows 1
        [ 0, 0, 1, 0 ],  # 1 knows 2
        [ 0, 0, 0, 1 ],  # 2 knows 3
        [ 1, 0, 0, 0 ]   # 3 knows 0
    ],
    [
        [ 0, 0, 0, 0, 0 ],  # 0 knows NOBODY
        [ 1, 0, 0, 0, 0 ],  # 1 knows 0
        [ 1, 0, 0, 0, 0 ],  # 2 knows 0
        [ 1, 0, 0, 0, 0 ],  # 3 knows 0
        [ 1, 0, 0, 0, 0 ]   # 4 knows 0
    ],
    [
        [ 0, 1, 0, 1, 0, 1 ],  # 0 knows 1, 3, 5
        [ 1, 0, 1, 1, 0, 0 ],  # 1 knows 0, 2, 3
        [ 0, 0, 0, 1, 1, 0 ],  # 2 knows 3, 4
        [ 0, 0, 0, 0, 0, 0 ],  # 3 knows NOBODY
        [ 0, 1, 0, 1, 0, 0 ],  # 4 knows 1, 3
        [ 1, 0, 1, 1, 0, 0 ]   # 5 knows 0, 2, 3
    ],
    [
        [ 0, 1, 1, 0 ],  # 0 knows 1 and 2
        [ 1, 0, 1, 0 ],  # 1 knows 0 and 2
        [ 0, 0, 0, 0 ],  # 2 knows NOBODY
        [ 0, 0, 0, 0 ]   # 3 knows NOBODY
    ],
    [
        [ 0, 0, 1, 1 ],  # 0 knows 2 and 3
        [ 1, 0, 0, 0 ],  # 1 knows 0
        [ 1, 1, 0, 1 ],  # 2 knows 0, 1 and 3
        [ 1, 1, 0, 0 ]   # 3 knows 0 and 1
    ]
);

print("\n");
foreach my $matrix (@matrices){
    printf(
        "Input: \@party = (\n%s\n);\nOutput: %s\n\n",
        join(
            "\n",
            map(
                "            " . $_,
                matrix_to_strings($matrix)
            )
        ),
        find_celebrity($matrix)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a square binary matrix (see below) that represents relationships among
# a group of people, find out if one of them is a Celebrity; someone is a
# Celebrity if they are the only person in the group who knows nobody else, but
# is known by everyone else
# Takes one argument:
# * A ref to a square binary matrix (the matrix is the same size in both
#   dimensions and consists only of ones (1's) and zeros (0's)) in which each
#   row represents a person in the group, and in each column a 1 or 0 appears
#   depending on whether or not the person knows the other person whose row
#   corresponds to that index (e.g.
#       [
#           [ 0, 0, 0, 0, 1, 0 ],  # 0 knows 4
#           [ 0, 0, 0, 0, 1, 0 ],  # 1 knows 4
#           [ 0, 0, 0, 0, 1, 0 ],  # 2 knows 4
#           [ 0, 0, 0, 0, 1, 0 ],  # 3 knows 4
#           [ 0, 0, 0, 0, 0, 0 ],  # 4 knows nobody
#           [ 0, 0, 0, 0, 1, 0 ]   # 5 knows 4
#       ]
#   )
# Returns:
# * The index of the person who has turned out to be the Celebrity (e.g. 4 in
#   the example above)
# * -1 if there is not a Celebrity in this group
################################################################################
sub find_celebrity{
    my $group = shift();

    my @known;
    my $aloof_person = undef;

    # Loop over each person and their possible
    # associates
    for my $person (0 .. $#$group){
        my $is_aloof = 1;

        for my $associate (0 .. $#$group){
            # Knowing oneself is wise, but not useful in
            # this context
            next
                if($person == $associate);

            if($group->[$person][$associate]){
                # This person is not aloof; make a note of
                # that, and that this associate is known
                $is_aloof = 0;
                $known[$associate]++;
            }
        }

        if($is_aloof){
            # This person is aloof- they don't know
            # anybody else.  If they aren't the first
            # one who's been found to be aloof, there can
            # be no Celebrity; otherwise, make a note of
            # who this is
            return(-1)
                if(defined($aloof_person));
            $aloof_person = $person;
        }
    }

    return(
        defined($aloof_person) ?
            # There was an aloof individual...
            ($known[$aloof_person] == $#$group) ?
                # This aloof person is the Celebrity
                $aloof_person
                :
                # There was no Celebrity if the one aloof
                # person isn't known by everybody else
                -1
            :
            # There was no Celebrity if nobody was aloof
            -1
    );

}



################################################################################
# Given a matrix, produce a set of strings of uniform length and formatting
# containing the contents of the matrix
# Takes one argument:
# * A ref to the matrix (e.g.
#       [
#           [ 4,  2 ],
#           [ 1, 12 ]
#       ]
#   )
# Returns:
# * A list of strings describing the contents of the matrix with uniform length
#   and formatting (e.g.
#       (
#           "[  4,  2 ]",
#           "[  1, 12 ]"
#       )
#   )
# Note that strings returned by this function will have square brackets at each
# end, but will neither have commas nor carriage returns to separate the
# rows in printed output, nor will they contain spaces for indenting; if the
# calling code requires any of these, it must provide them itself.
################################################################################
sub matrix_to_strings{
    use List::Util qw(max);

    # Make a printf() format that will
    # accommodate the longest value, textually
    # speaking, in the matrix
    my $value_format =
        "%"
        .
        # 3: Get the longest length amongst all the
        # rows
        max(
            map(
                # 2: Get the longest length in each row
                max(
                    # 1: Get the textual length for each value
                    map(length($_), @{$_})
                ),
                @{$ARG[0]}
            )
        )
        .
        "s";

    return(
        # 4: Make a list of lines of text containing
        # the contents of all matrix rows
        map(
            # 3: Put square brackets around each row
            sprintf(
                "[ %s ]",
                # 2: Make a string of uniform length out of
                # each matrix row
                join(
                    ", ",
                    # 1: Make a formatted string of uniform
                    # length out of each matrix value in the row
                    map(
                        sprintf($value_format, $_),
                        @{$_}
                    )
                )
            ),
            @{$ARG[0]}
        )
    );

}



