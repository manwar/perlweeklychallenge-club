#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_block(1, <<'END',      "1");
[4, 3, 2, 1]
[5, 4, 3, 2]
[6, 5, 4, 3]
END
test_block(1, <<'END',      "0");
[1, 2, 3]
[3, 2, 1]
END

test_line(2, "1 2 3 4 5 6 7 8", "1");
test_line(2, "1 3",             "0");

done_testing;
