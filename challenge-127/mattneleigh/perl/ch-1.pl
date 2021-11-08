#!/usr/bin/perl

use strict;
use warnings;

################################################################################
# Begin main execution
################################################################################

my @sets = (
    [
        [ 1, 2, 5, 3, 4 ],
        [ 4, 6, 7, 8, 9 ]
    ],
    [
        [ 1, 3, 5, 7, 9 ],
        [ 0, 2, 4, 6, 8 ]
    ],
    [
        # I'm just being cheeky here, but this
        # demonstrates how my solution behaves
        # with non-integer input and provides
        # an instance in which multiple
        # members of S2 are found in S1
        [ qw(Perl and UNIX are awesome) ],
        [ qw(Let's write some awesome code in Perl) ]
    ]
);
my $pair;
my @common;

foreach $pair (@sets){
    printf("Input: \@S1 = (%s)\n", join(", ", @{$pair->[0]}));
    printf("       \@S2 = (%s)\n", join(", ", @{$pair->[1]}));

    @common = sets_disjoint($pair->[0], $pair->[1]);

    if(scalar(@common)){
        # There were common members
        printf(
            "Output: 0 as the given two sets have common member(s): %s.\n",
            join(", ", @common)
        );
    } else{
        # There were no common members
        print(
            "Output: 1 as the given two sets do not have a common member.\n"
        );
    }
    print("\n");
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine if two sets are disjoint, or if not, which members they have in
# common; this will work for any two sets of scalar values that can be used as
# hash keys, but note that string matching will be case-sensitive
# Takes two arguments:
# * A ref to an array whose values form the members of Set 1
# * A ref to an array whose values form the members of Set 2
# Returns:
# * A list of values common to the two sets, in the order in which they appear
#   in Set 2; if this list is empty, the sets are disjoint (no common members)
################################################################################
sub sets_disjoint{
    my $set1 = shift();
    my $set2 = shift();

    my %set1_lookup;
    my @common_members = ();

    # Map Set 1 to a hash, storing a true
    # value for each member of the set,
    # using said members as the keys
    %set1_lookup = map({ $_ => 1 } @{$set1});

    foreach(@{$set2}){
        # Loop over Set 2, adding the value
        # to the common members list if a
        # true value is found in the lookup
        # hash, which would indicate that
        # this value was also found in Set 1
        push(@common_members, $_) if($set1_lookup{$_});
    }

    # Return the list to the caller
    return(@common_members);

}



