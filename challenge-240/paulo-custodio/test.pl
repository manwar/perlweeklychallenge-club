#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "-str Perl Python Pascal -chk ppp",        "true");
test_line(1, "-str Perl Raku          -chk rp",         "false");
test_line(1, "-str Perl Raku          -chk pr",         "true");
test_line(1, "-str Oracle Awk C       -chk oac",        "true");

test_line(2, "0 2 1 5 3 4",     "0 1 2 4 5 3");
test_line(2, "5 0 1 2 3 4",     "4 5 0 1 2 3");

done_testing;
