#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, quote("aa - two vowels and zero consonants"),      "true");
test_line(1, quote("iv - one vowel and one consonant"),         "true");
test_line(1, quote("hello - three vowels and two consonants"),  "false");
test_line(1, quote("aeiou - five vowels and zero consonants"),  "true");
test_line(1, quote("aei - three vowels and zero consonants"),   "true");

test_line(2, "192.168.1.45 192.168.1.0/24",     "true");
test_line(2, "10.0.0.256   10.0.0.0/24",        "false");
test_line(2, "172.16.8.9   172.16.8.9/32",      "true");
test_line(2, "172.16.4.5   172.16.0.0/14",      "true");
test_line(2, "192.0.2.0    192.0.2.0/25",       "true");

done_testing;
