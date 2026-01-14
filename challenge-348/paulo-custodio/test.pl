#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, "textbook",        'false');
test_line(1, "book",            'true');
test_line(1, "AbCdEfGh",        'true');
test_line(1, "rhythmmyth",      'false');
test_line(1, "UmpireeAudio",    'false');

test_line(2, "02:30 02:45",     1);
test_line(2, "11:55 12:15",     2);
test_line(2, "09:00 13:00",     4);
test_line(2, "23:45 00:30",     3);
test_line(2, "14:20 15:25",     2);

done_testing;
