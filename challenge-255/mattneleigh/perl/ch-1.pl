#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @string_pairs = (
    # Given cases
    [ "Perl",   "Preel"    ],
    [ "Weekly", "Weeakly"  ],
    [ "Box",    "Boxy"     ],

    # Additional test cases
    [ "Pizza",  "Pizzeria" ],
    [ "No",     "Matches"  ],
    [ "Peer",   "Peerless" ]
);

print("\n");
foreach my $string_pair (@string_pairs){
    printf(
        "Input: \$s = \"%s\"\n       \$t = \"%s\"\nOutput: %s\n\n",
        @{$string_pair},
        join(
            ", ",
            find_additional_characters(@{$string_pair})
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given two strings, find the characters in the second that are NOT present in
# the first, with quantity of characters being taken into account rather than
# mere presence alone (see below)
# Takes two arguments:
# * The first string (e.g. "Peer" )
# * The second string (e.g. "Peerless" )
# Returns:
# * A lexicographically sorted list of characters that are present in the
#   second string but not in the first (e.g. ( "e", "l", "s", "s" ) ).  Note
#   that 'e' is included once and 's' is included twice as that represents the
#   number of times each appears more in the second string than in the first.
################################################################################
sub find_additional_characters{

    my $char;
    my %chars;

    # Make a table of character counts from the second
    # argument
    foreach $char (split('', $ARG[1])){
        if($chars{$char}){
            $chars{$char}++;
        } else{
            $chars{$char} = 1;
        }
    }

    # Decrement (or remove entirely) the counts of
    # characters that appear in the first argument
    foreach $char (split('', $ARG[0])){
        if(exists($chars{$char})){
            $chars{$char}--;
            delete($chars{$char})
                unless($chars{$char});
        }
    }

    # Return a lexicographically sorted list of
    # remaining characters
    return(
        sort(
            # Make a list of remaining characters
            map(
                {
                    $char = $_;

                    # Repeat the character the appropriate
                    # number of times
                    map(
                        $char,
                        1 .. $chars{$char}
                    )
                }
                keys(%chars)
            )
        )
    );

}



