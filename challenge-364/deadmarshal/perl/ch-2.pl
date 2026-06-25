#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub goal_parser{
  my %h = ('' => 'o',al => 'al');
  $_[0] =~ s/\(((?:al)?)\)/$h{$1}/gr
}

is goal_parser('G()(al)'),'Goal','Example 1';
is goal_parser('G()()()()(al)'),'Gooooal','Example 2';
is goal_parser('(al)G(al)()()'),'alGaloo','Example 3';
is goal_parser('()G()G'),'oGoG','Example 4';
is goal_parser('(al)(al)G()()'),'alalGoo','Example 5';

