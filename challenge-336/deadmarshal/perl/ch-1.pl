#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;
use List::Util qw(reduce);
use ntheory qw(gcd);

sub equal_group{
  my %h;
  $h{$_}++ foreach @{$_[0]};
  (reduce{gcd($a,$b)} values %h) > 1
}

printf "%d\n",equal_group([1,1,2,2,2,2]);
printf "%d\n",equal_group([1,1,1,2,2,2,3,3]);
printf "%d\n",equal_group([5,5,5,5,5,5,7,7,7,7,7,7]);
printf "%d\n",equal_group([1,2,3,4]);
printf "%d\n",equal_group([8,8,9,9,10,10,11,11]);

