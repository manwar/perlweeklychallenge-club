#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(max sum);

use Test::More tests => 2;

is(cc([1,2,2]),4,'example 1');
is(cc([1,4,3,2]),7,'example 2');

sub cc {
  my @list=@{shift @_};
  my @n=sort {$list[$a] <=> $list[$b]} (0..$#list);
  my @k;
  foreach my $i (@n) {
    my @nr=(1);
    if ($i > 0 && $list[$i-1] < $list[$i]) {
      if (defined $k[$i-1]) {
        push @nr,$k[$i-1]+1;
      }
    }
    if ($i < $#list && $list[$i+1] < $list[$i]) {
      if (defined $k[$i+1]) {
        push @nr,$k[$i+1]+1;
      }
    }
    $k[$i]=max(@nr);
  }
  return sum(@k);
}
