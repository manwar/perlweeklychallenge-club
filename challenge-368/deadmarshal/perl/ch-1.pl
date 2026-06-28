#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max);
use Test::More tests => 5;

sub make_it_bigger{
  my $idx = -1;
  my @res;
  while(($idx = index $_[0],$_[1],$idx+1) != -1){
    substr my $s = $_[0],$idx,1,'';
    push @res,$s
  }
  max(@res)
}

is make_it_bigger('15456','5'),'1546','Example 1';
is make_it_bigger('7332','3'),'732','Example 2';
is make_it_bigger('2231','2'),'231','Example 3';
is make_it_bigger('543251','5'),'54321','Example 4';
is make_it_bigger('1921','1'),'921','Example 5';

