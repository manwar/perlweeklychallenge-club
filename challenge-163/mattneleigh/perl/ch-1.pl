#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @sets = (
    [ 1, 2, 3 ],
    [ 2, 3, 4 ]
);
my $set;

print("\n");

foreach $set (@sets){
    my @pairs = unique_pairs_from_list(@{$set});
    my $sum = 0;
    my $shown_work;

    # Do the math and document it; this will be
    # shared later...
    $shown_work = sprintf(
        "Since %s  =>  %s  =>  %d",
        join(" + ", map("(".$_->[0]." & ".$_->[1].")", @pairs)),
        join(
            " + ",
            map(
                # Where the actual math happens... and also
                # some output generation
                { my $a = ($_->[0] & $_->[1]); $sum += $a; $a; }
                @pairs
            )
        ),
        $sum
    );

    printf("Input: \@n = (%s)\n", join(", ", @{$set}));
    printf("Output: %d\n\n", $sum);
    print("$shown_work\n\n\n");
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Generate a sequence of unique pairs of items from a list
# Takes one argument:
# * The list of things to group into pairs, which can contain any set of scalar
#   values (e.g. (1, 2, 3) )
# Returns on success:
# * A list of array refs, each of which refers to a pair of values from the
#   original list (e.g. ( [ 1, 2 ], [ 1, 3 ], [ 2, 3 ] ) )
# Returns on error
# * undef if the list contains fewer than two elements (no pairs are possible)
################################################################################
sub unique_pairs_from_list{

    return(undef)
        unless(scalar(@ARG) > 1);

    my @pairs = ();

    for my $i (0 .. ($#ARG - 1)){
        for my $j (($i + 1) .. $#ARG){
            push(@pairs, [$ARG[$i], $ARG[$j]]);
        }
    }

    return(@pairs);

}



