#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "I love Perl",                 "Imaa ovelmaaa erlPmaaaa");
test_line(1, "Perl and Raku are friends",   "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa");
test_line(1, "The Weekly Challenge",        "heTmaa eeklyWmaaa hallengeCmaaaa");

test_line(2, "12 11 41 , 15 5 35",          "(36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47)");
test_line(2, "12 3 41 , 15 9 35 , 30 5 25", "(0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59)");

done_testing;
