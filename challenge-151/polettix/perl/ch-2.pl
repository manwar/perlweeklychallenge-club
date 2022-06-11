#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use Memoize 'memoize';
use List::Util 'max';

memoize('rob_the_house');
sub rob_the_house ($list, $start = 0) {
   return 0 if $start > $list->$#*;
   return $list->[$start]
      + max(rob_the_house($list, $start + 2),
            rob_the_house($list, $start + 3));
}

say rob_the_house([@ARGV]);
