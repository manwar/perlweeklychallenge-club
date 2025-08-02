#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(first);

sub reverse_equals{
  my ($src,$target) = @_;
  my $from = first {$src->[$_] != $target->[$_]} 0..$#$src;
  return 1 unless defined $from;
  my $to = first {$src->[$_] != $target->[$_]} reverse $from..$#$src;
  foreach my $i(0..$to-$from){
    return 0 if $src->[$from+$i] != $target->[$to-$i]
  }
  1;
}

printf "%d\n",reverse_equals([3,2,1,4],[1,2,3,4]);
printf "%d\n",reverse_equals([1,3,4],[4,1,3]);
printf "%d\n",reverse_equals([2],[2]);

