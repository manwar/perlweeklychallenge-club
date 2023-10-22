#!/usr/bin/env perl
use v5.24;
use warnings;
use List::Util 'reductions';

say '(', join(', ', running_sum(@ARGV)), ')';

sub running_sum { reductions { $a + $b } @_ }
