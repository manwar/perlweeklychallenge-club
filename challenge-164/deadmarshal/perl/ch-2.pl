#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum0);

sub is_happy{
  my ($n) = @_;
  my %seen;
  while(1){
    $n = sum0(map {$_ ** 2} split //, $n);
    return 1 if $n == 1;
    return 0 if $seen{$n}++;
  }
}

sub happy_numbers{
  my $i = 0;
  my $count = 0;
  while($count < 8){
    if(is_happy($i)){
      print "$i ";
      $count++;
    }
    $i++;
  }
}

happy_numbers;
