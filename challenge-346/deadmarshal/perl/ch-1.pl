#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max);

sub longest_parenthesis{
  my @s = split '',$_[0];
  my ($max,@stk) = (0,-1);
  foreach my $i(0..$#s) {
    if($s[$i] eq '(') {push @stk,$i}
    else {
      pop @stk;
      if(@stk == 0) {push @stk,$i}
      else {
	$max = max($max,$i - $stk[$#stk])
      }
    }
  }
  $max
}

printf "%d\n",longest_parenthesis('(()())');
printf "%d\n",longest_parenthesis(')()())');
printf "%d\n",longest_parenthesis('((()))()(((()');
printf "%d\n",longest_parenthesis('))))((()(');
printf "%d\n",longest_parenthesis('()(()');

