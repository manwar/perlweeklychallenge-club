#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "Perl Preel",      "e");
test_line(1, "Weekly Weeakly",  "a");
test_line(1, "Box Boxy",        "y");

test_line(2, "hit  Joe hit a ball, the hit ball flew far after it was hit.",    "ball");
test_line(2, "the  Perl and Raku belong to the same family. ".
             "Perl is the most popular language in the weekly challenge.",      "Perl");

done_testing;
