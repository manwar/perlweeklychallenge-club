#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub outermost_parentheses{
  my %h = ('(' => 1, ')' => 0);
  my $depth = 0;
  join '',
    map $h{$_} == ($depth += $_ eq '(' ? 1 : -1) ? '' : $_,
    split '',$_[0]
}

is outermost_parentheses('()()()'),'','Example 1';
is outermost_parentheses('(((())))'),'((()))','Example 2';
is outermost_parentheses('(()())(())'),'()()()','Example 3';
is outermost_parentheses('()((()))()'),'(())','Example 4';
is outermost_parentheses('(()(()))(()())'),'()(())()()','Example 5';

done_testing();

