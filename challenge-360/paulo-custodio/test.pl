#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, quote("Hi")." 5",      "*Hi**");
test_line(1, quote("Code")." 10",   "***Code***");
test_line(1, quote("Hello")." 9",   "**Hello**");
test_line(1, quote("Perl")." 4",    "Perl");
test_line(1, quote("A")." 7",       "***A***");
test_line(1, quote("")." 5",        "*****");

test_line(2, "The quick brown fox",                 "brown fox quick The");
test_line(2, "Hello    World!   How   are you?",    "are Hello How World! you?");
test_line(2, "Hello",                               "Hello");
test_line(2, "Hello, World! How are you?",          "are Hello, How World! you?");
test_line(2, "I have 2 apples and 3 bananas!",      "2 3 and apples bananas! have I");

done_testing;
