#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl < input-file
#

while (my $rows = <>) {
    chomp $rows;

    #
    # 0-th row
    #
    my @row = (1);
    say "@row";

    foreach (1 .. $rows) {
        #
        # Calculate the next row from the current row
        #
        my @new = map {($_ == 0    ? 0 : $row [$_ - 1]) +
                       ($_ == @row ? 0 : $row [$_])} 0 .. @row;

        #
        # Print
        #
        say "@new";

        #
        # New row becomes current row
        #
        @row = @new;
    }
}
