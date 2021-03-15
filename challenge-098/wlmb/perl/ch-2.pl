#!/usr/bin/env perl
# Perl weekly challenge 098
# Task 2: Search Insert Position
#
# See https://wlmb.github.io/2021/02/01/PWC098/#task-2-search-insert-position
use warnings;
use strict;
use v5.12;
use List::Util qw(uniq);
use List::MoreUtils qw(first_index);

my ($N, @N)=@ARGV;
say "Input: \@N=(", join(", ", @N), ") and \$N=$N\n",
    "Output: ",
    first_index {$_==$N} sort {$a<=>$b} uniq (@N, $N);
