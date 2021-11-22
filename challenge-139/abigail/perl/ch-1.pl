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
# Run as: perl ch-1.pl < input-file
#

#
# A list is sorted if it doesn't contain two successive elements
# where the first element is larger than the second.
#

while (<>) {
    my @list = /[0-9]+/g;
    say grep ({$list [$_ - 1] > $list [$_]} 1 .. $#list) ? 0 : 1
}
