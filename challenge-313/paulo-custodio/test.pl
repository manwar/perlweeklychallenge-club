#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "perl perrrl",                     "true");
test_line(1, "raku rrakuuuu",                   "true");
test_line(1, "python perl",                     "false");
test_line(1, "coffeescript cofffeescccript",    "true");

test_line(2, "p-er?l",              "l-re?p");
test_line(2, "wee-k!L-y",           "yLk-e!e-w");
test_line(2, "_c-!h_all-en!g_e",    "_e-!g_nel-la!h_c");

done_testing;
