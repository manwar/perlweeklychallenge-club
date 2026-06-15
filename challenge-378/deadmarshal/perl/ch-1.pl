#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(uniq);
use Data::Show;

sub second_largest_digit{
  (sort {$b <=> $a} uniq $_[0] =~ /\d/g)[1] // -1
}

show second_largest_digit('aaaaa77777');
show second_largest_digit('abcde');
show second_largest_digit('9zero8eight7seven9');
show second_largest_digit('xyz9876543210');
show second_largest_digit('4abc4def2ghi8jkl2');

