#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two arrays of strings.

Write a script to return true if the two given array represent the same strings otherwise false.
Example 1

Input: @arr1 = ("a", "bc")
       @arr2 = ("ab", "c")
Output: true

Array 1: "a" + "bc" = "abc"
Array 2: "ab" + "c" = "abc"

Example 2

Input: @arr1 = ("a", "b", "c")
       @arr2 = ("a", "bc")
Output: true

Array 1: "a" + "b" + "c" = "abc"
Array 2: "a" + "bc" = "abc"

Example 3

Input: @arr1 = ("a", "bc")
       @arr2 = ("a", "c", "b")
Output: false

Array 1: "a" + "bc" = "abc"
Array 2: "a" + "c" + "b" = "acb"

Example 4

Input: @arr1 = ("ab", "c", "")
       @arr2 = ("", "a", "bc")
Output: true

Array 1: "ab" + "c" + "" = "abc"
Array 2: ""  + "a" + "bc" = "abc"

Example 5

Input: @arr1 = ("p", "e", "r", "l")
       @arr2 = ("perl")
Output: true

Array 1: "p" + "e" + "r" + "l" = "perl"
Array 2: "perl"
=cut

use constant { true => 1, false => 0 };
use Test2::V0 -no_srand => 1;


is(are_equal([("a", "bc")], [("ab", "c")]), true, 'Example 1');
is(are_equal([("a", "b", "c")], [("a", "bc")]), true, 'Example 2');
is(are_equal([("a", "bc")], [("a", "c", "b")]), false, 'Example 3');
is(are_equal([("ab", "c", "")], [("", "a", "bc")]), true, 'Example 4');
is(are_equal([("p", "e", "r", "l")], [("perl")]), true, 'Example 5');
done_testing();



sub are_equal
{
     my ($aref_1, $aref_2) = @_;
     if ( join('', @$aref_1) eq join('', @$aref_2) )
     {
          return true;
     }
     return false;
}
