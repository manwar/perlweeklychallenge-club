# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#
#===============================================================================
# FILE: CommonBaseString.t
# DESCRIPTION: Unit test for CommonBaseString
#===============================================================================

use strict;
use warnings;
use v5.30;

use Test2::V0;
use lib "lib";

use CommonBaseString qw/ commonPrefix /;

is( commonPrefix("abc", "def"), [ ],           "commonPrefix length 0" );
is( commonPrefix("aaa", "abc"), [ "a" ],       "commonPrefix length 1" );
is( commonPrefix("aaa", "aac"), [ "a", "aa" ], "commonPrefix length 2" );
is( commonPrefix("abab", "abababab"), [ "a", "ab", "aba", "abab" ], "commonPrefix 2 possibilities" );

is( CommonBaseString->new("abcdabcd", "abcdabcdabcdabcd")->run, [ "abcd", "abcdabcd" ], "Example 1");
is( CommonBaseString->new("aaa", "a")->run, [ "a" ], "Example 2");


done_testing();
