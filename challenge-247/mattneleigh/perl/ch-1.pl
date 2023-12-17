#!/usr/bin/perl

use strict;
use warnings;
use English;

use List::Util qw(max);

################################################################################
# Begin main execution
################################################################################

my @secret_santa_lists = (
    # Given cases
    [
        "Mr. Wall",
        "Mrs. Wall",
        "Mr. Anwar",
        "Mrs. Anwar",
        "Mr. Conway",
        "Mr. Cross"
    ],
    [
        "Mr. Wall",
        "Mrs. Wall",
        "Mr. Anwar"
    ],

    # Additional test cases
    # Single name
    [
        "Mr. Jones"
    ],
    # Everyone in the same family
    [
        "Mr. Smith",
        "Mrs. Smith",
        "Ms. Smith",
        "Dr. Smith"
    ],
    # Nobody in the same family
    [
        "Ms. Williams",
        "Mr. Stephenson",
        "Dr. Mifune",
        "Mrs. Hernandez",
        "Mr. Donovan",
        "Dr. Hartford",
        "Ms. Schneider"
    ]
);

print("\n");
foreach my $secret_santa_list (@secret_santa_lists){
    # Make a pattern that accommodets the
    # length of givers' names while left
    # justifying them
    my $pair_pattern =
        "    %-"
        .
        max(map(length($_), @{$secret_santa_list}))
        .
        "s -> %s";

    printf(
        "Input: \@names = (\n%s\n                );\n"
        .
        "Output:\n%s\n\n",
        join(
            "\n",
            map(
                "                 \'" . $_ . "\'",
                @{$secret_santa_list}
            )
        ),
        join(
            "\n",
            map(
                sprintf($pair_pattern, @{$_}),
                secret_santa_selector(@{$secret_santa_list})
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of names, produce pairs of gift givers and recipients for the
# Secret Santa ritual common during the festive winter holiday season; there is
# a random component to this selection, but effort will be taken to ensure that
# individuals who appear to be from the same family will not be paired as gift
# givers/recipients if there are enough people in the list
# Takes one argument:
# * A list of names, which must each consist of a given name or title and a
#   surname, separated by a space (e.g.
#       (
#           "Mr. Wall",
#           "Mrs. Wall",
#           "Mr. Anwar",
#           "Mrs. Anwar",
#           "Mr. Conway",
#           "Mr. Cross"
#       )
#   )
# Returns:
# * A list of selected giver/reciever pairs, sorted lexicographically by
#   giver's name (e.g.
#       (
#           [ "Mr. Anwar",  "Mr. Conway" ],
#           [ "Mrs. Anwar", "Mr. Cross"  ],
#           [ "Mr. Conway", "Mr. Wall"   ],
#           [ "Mr. Cross",  "Mrs. Wall"  ],
#           [ "Mr. Wall",   "Mr. Anwar"  ],
#           [ "Mrs. Wall",  "Mrs. Anwar" ]
#       )
#   )
################################################################################
sub secret_santa_selector{
    use List::Util qw(max);

    my @names;
    my %families = ();
    my $offset = 0;

    # The names must be sorted so families are
    # grouped together even if they weren't so
    # in the input (see below); sort by
    # surname first, then given name if
    # surnames match.  The original un-split
    # names are also stored, for later.
    @names = sort(
        {
            $a->[1] eq $b->[1] ?
                $a->[0] cmp $b->[0]
                :
                $a->[1] cmp $b->[1]
        }
        map(
            [ split(" ", $_), $_ ],
            @ARG
        )
    );

    # Loop over the list of names to count how
    # many are in each family
    for my $name (@names){
        if($families{$name->[1]}){
            # We have seen this family before-
            # increment its count
            $families{$name->[1]}++;
        } else{
            # We have not seen this family before-
            # initialize its count
            $families{$name->[1]} = 1;
        }
    }

    # Calculate a rotation offset that is at
    # least the number of people in the
    # largest family, but not so large that
    # the largest family is likely to loop
    # back on itself; this requires that
    # the list be sorted so members of each
    # family are grouped together within the
    # list
    $offset = max(map($families{$_}, keys(%families)));
    if(($offset == scalar(@names)) || ($offset == 1)){
        # One family takes up the entire list,
        # or no family has more than one member;
        # just do a random offset that's at
        # least one
        $offset = int(rand($#names)) + 1;
    } else{
        # There is at least one family with at
        # least two members but it does not take
        # up the whole list- apply a random
        # offset to the base offset
        $offset += int(rand($#names - $offset));
    }

    # Don't need this anymore
    %families = ();

    return(
        # Make a list of the un-split sorted names
        # paired with their gift recipients, the
        # latter selected by rotating the list by
        # $offset places
        map(
            [
                $names[$_][2],
                $names[($_ - $offset) % scalar(@names)][2]
            ],
            0 .. $#names
        )
    );

}



