#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, quote_list("Perl and Raku belong to the same family.",
                        "I love Perl.",
                        "The Perl and Raku Conference."),       8);
test_line(1, quote_list("The Weekly Challenge.",
                        "Python is the most popular guest language.",
                        "Team PWC has over 300 members."),      7);

test_line(2, "10 4 8 3",        "(15, 1, 11, 22)");
test_line(2, "1",               "(0)");
test_line(2, "1 2 3 4 5",       "(14, 11, 6, 1, 10)");

done_testing;
