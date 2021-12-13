#!/usr/bin/perl

=head1

Week 143:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-143

Task #1: Calculator

    You are given a string, `$s`, containing mathematical expression.

    Write a script to print the result of the mathematical expression. To keep it simple, please only accept `+ - * ()`.

=cut

use strict;
use warnings;
use Test::More;

is(eval qq|10 + 20 - 5|, 25, 'Example 1');
is(eval qq|(10 + 20 - 5) * 2|, 50, 'Example 2');

done_testing;

