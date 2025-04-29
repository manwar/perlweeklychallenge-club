#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(min);
use Set::Scalar;

sub minimum_common{
  (min (Set::Scalar->new(@{$_[0]})
	->intersection(Set::Scalar->new(@{$_[1]}))
	->members)) // -1
}

printf "%d\n",minimum_common([1,2,3,4],[3,4,5,6]);
printf "%d\n",minimum_common([1,2,3],[2,4]);
printf "%d\n",minimum_common([1,2,3,4],[5,6,7,8]);

