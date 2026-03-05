#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "Perl is my friend,Perl and Raku are friend",                          2);
test_line(1, "Perl and Python are very similar,Python is top in guest languages",   1);
test_line(1, "Perl is imperative Lisp is functional,Crystal is similar to Ruby",    0);

test_line(2, "1 2 3 4 5",   4);
test_line(2, "5 7 1 7",     1);

done_testing;
