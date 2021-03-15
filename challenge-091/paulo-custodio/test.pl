#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

# forth
is `gforth -e 1122234 forth/ch-1.fs`, "21321314\n";
is `gforth -e 2333445 forth/ch-1.fs`, "12332415\n";
is `gforth -e 12345   forth/ch-1.fs`, "1112131415\n";

is `gforth -e '1 2 1 2    4' forth/ch-2.fs`, "1 \n";
is `gforth -e '1 3 1 2    4' forth/ch-2.fs`, "0 \n";
is `gforth -e '2 1 1 0 2  5' forth/ch-2.fs`, "0 \n";

# perl
is `perl perl/ch-1.pl 1122234`, "21321314\n";
is `perl perl/ch-1.pl 2333445`, "12332415\n";
is `perl perl/ch-1.pl 12345`, "1112131415\n";

is `perl perl/ch-1a.pl 1122234`, "21321314\n";
is `perl perl/ch-1a.pl 2333445`, "12332415\n";
is `perl perl/ch-1a.pl 12345`, "1112131415\n";

is `perl perl/ch-2.pl 1 2 1 2  `, "1\n";
is `perl perl/ch-2.pl 1 3 1 2  `, "0\n";
is `perl perl/ch-2.pl 2 1 1 0 2`, "0\n";


done_testing;
