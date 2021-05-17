#!/usr/bin/env raku

use Test;
plan 2;

# with help from https://www.geeksforgeeks.org/check-if-n-can-be-represented-as-sum-of-positive-integers-containing-digit-d-at-least-once/

is represent-integer(25, 7), 0, 'Example 1';
is represent-integer(24, 7), 1, 'Example 2';

sub represent-integer(UInt $N, UInt $D)
{
    +($N, * - $D ... * <= $D).first(*.index: $D).so;
}
