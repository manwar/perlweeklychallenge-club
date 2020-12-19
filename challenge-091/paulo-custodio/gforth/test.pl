#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

# gforth
is `gforth -e 1122234 ch-1.fth`, "21321314\n";
is `gforth -e 2333445 ch-1.fth`, "12332415\n";
is `gforth -e 12345   ch-1.fth`, "1112131415\n";

is `gforth -e '1 2 1 2    4' ch-2.fth`, "1 \n";
is `gforth -e '1 3 1 2    4' ch-2.fth`, "0 \n";
is `gforth -e '2 1 1 0 2  5' ch-2.fth`, "0 \n";

done_testing;
