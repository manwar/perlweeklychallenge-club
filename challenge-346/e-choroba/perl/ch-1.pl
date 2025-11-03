#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub longest_parenthesis($str) {
    $str =~ s/^\)+//;
    $str =~ s/\(+$//;
    for my $length (reverse 2 .. length $str) {
      FROM:
        for my $from (0 .. length($str) - $length) {
            my $depth = 0;
            for my $pos ($from .. $from + $length - 1) {
                $depth += substr($str, $pos, 1) eq '(' ? 1 : -1;
                next FROM if $depth < 0;
            }
            return $length if 0 == $depth;
        }
    }
    return 0
}

use Test::More tests => 5 + 3;

is longest_parenthesis('(()())'), 6, 'Example 1';
is longest_parenthesis(')()())'), 4, 'Example 2';
is longest_parenthesis('((()))()(((()'), 8, 'Example 3';
is longest_parenthesis('))))((()('), 2, 'Example 4';
is longest_parenthesis('()(()'), 2, 'Example 5';

is longest_parenthesis(''), 0, 'Empty string';
is longest_parenthesis('('), 0, 'Single char opening';
is longest_parenthesis(')'), 0, 'Single char closing';
is longest_parenthesis('))))(((('), 0, 'Zero';
is longest_parenthesis('(((())(()))((((())()()())'), 12, 'Larger';
