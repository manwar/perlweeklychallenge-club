#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub count_prefixes{
  scalar grep {index($_[1], $_) == 0} @{$_[0]}
}

is count_prefixes(['a','ap','app','apple','banana'],'apple'),
  4,'Example 1';
is count_prefixes(['cat','dog','fish'],'bird'),0,'Example 2';
is count_prefixes(['hello','he','hell','heaven','he'],'hello'),
  4,'Example 3';
is count_prefixes(['','code','coding','cod'],'coding'),
  3,'Example 4';
is count_prefixes(['p','pr','pro','prog','progr','progra','program'],
		  'program'),7,'Example 5';

