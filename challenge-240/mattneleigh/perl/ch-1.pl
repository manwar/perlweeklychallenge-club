#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @string_sets = (
    [
        [ "Perl", "Python", "Pascal" ],
        "ppp"
    ],
    [
        [ "Perl", "Raku" ],
        "rp"
    ],
    [
        [ "Oracle", "Awk", "C" ],
        "oac"
    ]
);

print("\n");
foreach my $string_set (@string_sets){
    printf(
        "Input: \@str = (%s)\n       \$chk = %s\nOutput: %s\n\n",
        join(", ", map("\"" . $_ . "\"", @{$string_set->[0]})),
        $string_set->[1],
        is_acronym($string_set->[1], @{$string_set->[0]}) ?
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
# Determine whether a set of words can form a particular acronym; case is
# ignored when performing this check
# Takes two arguments:
# * The intended acronym (e.g. "perl")
# * A list of words whose ability to form the supplied acronym is to be
#   verified (e.g. ( "Pathologically", "Eclectic", "Rubbish", "Lister" ) )
# Returns:
# * A true value if the supplied words will form the specified acronym (as they
#   will in the example above)
# * A false value if the supplied words will NOT form the specified acronym
################################################################################
sub is_acronym{

    return(
        # Lower-case the first string
        lc(shift())
        eq
        # 2: Concatenate of all the first letters
        # from subsequent strings
        join(
            "",
            # 1: Make a list of lower-cased first letters
            # from subsequent strings
            map(
                lc(substr($_, 0, 1)),
                @ARG
            )
        )
    );

}



