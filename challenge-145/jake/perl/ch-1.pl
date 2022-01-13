#!/usr/bin/env perl

use warnings;
use strict;
use feature 'say';
use List::Util qw(sum);
use List::MoreUtils qw(pairwise);

my @list1 = (1, 2, 3);
my @list2 = (4, 5, 6);

say sum ( pairwise { $a * $b } @list1, @list2 );