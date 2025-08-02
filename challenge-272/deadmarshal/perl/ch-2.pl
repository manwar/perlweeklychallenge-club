#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum0);
use List::MoreUtils qw(slide);

sub string_score{
  sum0 slide {abs(ord($b) - ord($a))} split '',$_[0]
}

printf "%d\n",string_score('hello');
printf "%d\n",string_score('perl');
printf "%d\n",string_score('raku');

