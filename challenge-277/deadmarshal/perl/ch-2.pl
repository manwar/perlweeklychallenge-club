#!/usr/bin/env perl
use strict;
use warnings;
use Algorithm::Combinatorics qw(combinations);
use List::AllUtils qw(min uniq);

sub strong_pairs{
  scalar grep{abs($$_[0] - $$_[1]) < min(@$_)}
    combinations([uniq @{$_[0]}],2)
}

printf "%d\n",strong_pairs([1,2,3,4,5]);
printf "%d\n",strong_pairs([5,7,1,7]);

