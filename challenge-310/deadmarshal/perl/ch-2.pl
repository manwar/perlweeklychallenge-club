#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(mesh);
use Data::Show;

sub sort_even_odd{
  grep {defined}
    (mesh[sort{$a <=> $b}@{$_[0]}[grep{!($_%2)} 0..$#{$_[0]}]],
     [sort{$b <=> $a}@{$_[0]}[grep{$_%2} 0..$#{$_[0]}]]);
}

print show sort_even_odd([4,1,2,3]);
print show sort_even_odd([3,1]);
print show sort_even_odd([5,3,2,1,4]);

