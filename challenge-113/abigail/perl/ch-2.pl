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
# Note that the "binary tree" part of the challenge is a red herring.
# We just have a bunch of numbers, and we want to replace each number
# with the sum of all the numbers, minus the number itself.
#
# We decide to complete ignore the binary tree part. Just like in a
# previous challenge, it's absolutely not stated what the format of
# binary tree is -- and the maker of the challenge gave a simple
# example of a 7 node tree, one which would immediately break down
# if we added an 8th node without adding an additional layer.
#
# So, we will just take a row of numbers as input.
#

use List::Util qw [sum];

while (<>) {
    my $sum = sum my @num = /-?[0-9]+/g;
    say join " " => map {$sum - $_} @num;
}
