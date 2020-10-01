#!/usr/bin/env perl

use strict;
use warnings;
use v5.30;

my @N = sort {$a<=>$b} grep {$_ > 0} @ARGV ? split /,/, shift : (5, 2, -2, 0, 123, 1);
unshift @N, 0;
$N[$_]-$N[$_-1] > 1 ? say(++$N[$_-1]) && exit 0 : next for 1..$#N;
say 1;
