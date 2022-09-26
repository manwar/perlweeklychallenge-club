#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @lists = (
    [ "ab1234", "cd5678", "ef1342" ],
    [ "pq1122", "rs3334" ]
);

print("\n");
foreach my $list (@lists){
    my $seq = 0;

    printf(
        "Input: \@list = (%s)\nOutput: (%s)\n\n",
        join(
            ", ",
            map(sprintf("'%s'", $_), @{$list})
        ),
        join(
            ", ",
            map(
                # Swap all non-digit characters at the start of
                # each list element with a zero-padded two-digit
                # string based on our zero-indexed sequence
                { s/^\D+/sprintf("%02d", $seq++)/e; sprintf("'%s'", $_); }
                @{$list}
            )
        )
    );

}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



