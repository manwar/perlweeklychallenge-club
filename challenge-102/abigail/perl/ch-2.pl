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

#
# Working from the end of the required string backwards, we alternate
# placing a hash, and placing a number. We place them in an array @out,
# and at the end, print out said array in reverse order.
#

while (my $index = <>) {
    chomp $index;
    my @out;
    my $hash = 0;
    while ($index) {
        if ($hash = !$hash) {
            push @out => "#";
            $index --;
        }
        else {
            push @out =>      $index + 1;
            $index -= length ($index + 1);
        }
    }
    say join "" => reverse @out;
}
