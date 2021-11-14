#!/usr/bin/perl

use strict;
use warnings;

use English;

################################################################################
# Begin main execution
################################################################################

my @player_ages = (
    [20, "Alex"  ],
    [28, "Joe"   ],
    [38, "Mike"  ],
    [18, "Alex"  ],
    [25, "David" ],
    [18, "Simon" ]
);
my @player_names = (
    ["Alex", "Stewart"],
    ["Joe",  "Root"   ],
    ["Mike", "Gatting"],
    ["Joe",  "Blog"   ],
    ["Alex", "Jones"  ],
    ["Simon","Duane"  ]
);
my $row;

print("\nMerged rows:\n");
foreach $row (@{hash_join(\@player_ages, 1, \@player_names, 0)}){
    print_table_row($row);
}
print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Perform a hash join of two lists of table rows, based on the specified key
# fields.  The original arrays will NOT be modified.  The order of rows in the
# merged list will depend on the order of rows with matching keys in the Build
# and Probe lists.
# Takes four arguments:
# * A ref to a list of table rows; this will be treated as the Build List
# * The index of the field to use as the key from the Build List
# * A ref to a list of table rows; this will be treated as the Probe List
# * The index of the field to use as the key from the Probe List
# Returns:
# * A ref to a list of merged table rows
# Adapted from the algorithm described at:
# http://www.dcs.ed.ac.uk/home/tz/phd/thesis/node21.htm
################################################################################
sub hash_join{
    my $build = shift();
    my $build_index = shift();
    my $probe = shift();
    my $probe_index = shift();

    my $row;
    my $key;
    my %table = ();
    my $joined = [];

    # Build phase- build a table of things
    # from the build rows, using the specified
    # field as the key; make each entry in the
    # table a list of rows, in case more than
    # one thing matches the key
    foreach $row (@{$build}){
        # Copy the row from the build list, then
        # remove the key from the row before
        # adding to that key's list in the table
        $row = [ @{$row} ];
        $key = splice(@{$row}, $build_index, 1);
        push(@{$table{$key}}, $row);
    }

    # Probe phase- loop over the probe list,
    # examining the table for occurances of the
    # specified key...
    foreach $row (@{$probe}){
        $key = $row->[$probe_index];

        if($table{$key}){
            # The key from this row appears in the build
            # table- copy the row and delete the key
            $row = [ @{$row} ];
            splice(@{$row}, $probe_index, 1);

            # Loop over everything in the table for this
            # key and merge the built row with the probe
            # row, storing the combination in the joined
            # list
            foreach my $built_row (@{$table{$key}}){
                push(@{$joined}, [ @{$built_row}, $key, @{$row} ]);
            }
        }
    }

    return($joined);

}



################################################################################
# Print the contents of a table row to STDOUT
# Takes one argument:
# * A ref to the row to print out, which must be an array of values that will
#   be interpreted as strings
# Returns no meaningful value
################################################################################
sub print_table_row{

    printf(
        "%s\n",
        join(
            "    ",
            map(
                { sprintf("%8s", $_); }
                @{$ARG[0]}
            )
        )
    );

}



