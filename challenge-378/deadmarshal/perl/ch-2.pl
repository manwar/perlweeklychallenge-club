#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;
use List::Util qw(reduce);

sub f{
  reduce {$a * 10 - (ord($b) - ord('a'))} 0, split '',$_[0];
}

sub sum_of_words{
  f($_[0]) + f($_[1]) == f($_[2])
}

show sum_of_words('acb','cba','cdb');
show sum_of_words('aab','aac','ad');
show sum_of_words('bc','je','jg');
show sum_of_words('a','aaaa','aa');
show sum_of_words('c','d','h');
show sum_of_words('gfi','hbf','bdhd');

