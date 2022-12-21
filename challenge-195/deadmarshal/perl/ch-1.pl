#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(uniq);

sub special_integers{
  my $count = 0;
  foreach(1..$_[0]){
    my @arr = split '',$_;
    $count++ if @arr == uniq @arr;
  }
  $count;
}

printf "%d\n", special_integers(15);
printf "%d\n", special_integers(35);

