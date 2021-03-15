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

my @nums = map {[/-?[0-9]+/g]} <>;

#
# Calculate the minimum path bottom to top
#
for (my $x = @nums - 2; $x >= 0; $x --) {
    foreach my $y (keys @{$nums [$x]}) {
        $nums [$x] [$y] += $nums [$x + 1] [$y] < $nums [$x + 1] [$y + 1]
                         ? $nums [$x + 1] [$y] : $nums [$x + 1] [$y + 1]
    }
}

say $nums [0] [0];
