#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(product);

sub persistence_sort{
  my $helper = sub{
    my ($sum,$n) = (0,@_);
    $n = do{$sum++; product split '',$n} until $n < 10;
    $sum
  };
  sort{$helper->($a) <=> $helper->($b) || $a <=> $b} @{$_[0]}
}

printf "(%s)\n",join ',',persistence_sort([15,99,1,34]);
printf "(%s)\n",join ',',persistence_sort([50,25,33,22]);

