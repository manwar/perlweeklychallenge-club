#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
use Text::Diff;

require "../../challenge-001/paulo-custodio/testlib.pl";

test_block(1, <<'IN', "", "temp.svg");
53,10
53,10,23,30
23,30
IN
is diff("ch-1.svg", "temp.svg"), "", "check output file";
unlink("temp.svg");

test_block(2, <<'IN', "", "temp.svg");
333,129  39,189 140,156 292,134 393,52  160,166 362,122  13,193
341,104 320,113 109,177 203,152 343,100 225,110  23,186 282,102
284,98  205,133 297,114 292,126 339,112 327,79  253,136  61,169
128,176 346,72  316,103 124,162  65,181 159,137 212,116 337,86
215,136 153,137 390,104 100,180  76,188  77,181  69,195  92,186
275,96  250,147  34,174 213,134 186,129 189,154 361,82  363,89
IN
is diff("ch-2.svg", "temp.svg"), "", "check output file";
unlink("temp.svg");

done_testing;
