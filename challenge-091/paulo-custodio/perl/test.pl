#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

# perl
is `perl ch-1.pl 1122234`, "21321314\n";
is `perl ch-1.pl 2333445`, "12332415\n";
is `perl ch-1.pl 12345`, "1112131415\n";

is `perl ch-1a.pl 1122234`, "21321314\n";
is `perl ch-1a.pl 2333445`, "12332415\n";
is `perl ch-1a.pl 12345`, "1112131415\n";

is `perl ch-2.pl 1 2 1 2`, "1\n";
is `perl ch-2.pl 2 1 1 0 2`, "0\n";

done_testing;
