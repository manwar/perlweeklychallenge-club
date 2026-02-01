#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "abc abb ab",  2);
test_line(1, "ayz cyz xyz", -1);
test_line(1, "yza yzb yzc", 3);

test_line(2, "swpc tyad azbe",  2);
test_line(2, "cba daf ghi",     1);
test_line(2, "a b c",           0);

done_testing;
