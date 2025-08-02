#!/usr/bin/env perl
use strict;
use warnings;
use Algorithm::Combinatorics qw(permutations);
use List::MoreUtils qw(onlyidx uniq);

sub dictionary_rank{
  1+onlyidx{$_ eq $_[0]}
    sort{$a cmp $b}
    uniq map{join'',@$_}
    permutations([split '',$_[0]])
}

printf "%d\n",dictionary_rank('CAT');
printf "%d\n",dictionary_rank('GOOGLE');
printf "%d\n",dictionary_rank('SECRET');

