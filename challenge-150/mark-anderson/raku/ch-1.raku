#!/usr/bin/env raku

use Test;

is fib-words(1234, 5678), 7;
is fib-words(123, 45678), 4;
is fib-words('abcd', 'efgh'), 'g';
is fib-words('abc', 'defgh'), 'd';

sub fib-words(\a, \b)
{
    (a, b, * ~ * ... *.chars > 50).tail.substr(50, 1);
}
