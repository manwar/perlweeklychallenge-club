#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

my %DEPTH2DEL = ('(' => 1, ')' => 0);
sub outermost_parentheses($str) {
    my $depth = 0;
    return join "",
            map $DEPTH2DEL{$_} == ($depth += $_ eq '(' ? 1 : -1) ? "" : $_,
            split //, $str
}

use Test::More tests => 5;

is outermost_parentheses('()()()'), '', 'Example 1';
is outermost_parentheses('(((())))'), '((()))', 'Example 2';
is outermost_parentheses('(()())(())'), '()()()', 'Example 3';
is outermost_parentheses('()((()))()'), '(())', 'Example 4';
is outermost_parentheses('(()(()))(()())'), '()(())()()', 'Example 5';
