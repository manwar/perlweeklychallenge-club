#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "Perl Rust Raku",      "r");
test_line(1, "love live leave",     "e l v");

test_line(2, "1 17 8",      "(1, 8, 17), (17, 8, 1)");
test_line(2, "2 2 2",       "(2, 2, 2)");

done_testing;
