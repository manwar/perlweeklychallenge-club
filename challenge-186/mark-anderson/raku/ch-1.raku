#!/usr/bin/env raku
use Test;

my @a = qw/1 2 3/;
my @b = qw/a b c/;

# Going with >>,<< since that ensures the arrays are the same length.

is-deeply (flat |@a >>,<< |@b), qw/1 a 2 b 3 c/;
is-deeply (flat |@b >>,<< |@a), qw/a 1 b 2 c 3/;
