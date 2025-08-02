#!/usr/bin/env perl
use strict;
use warnings;
use List::MoreUtils qw(uniq pairwise);

sub buddy_strings{
  return 0 if length($_[0]) != length($_[1]);
  my @s1 = split '',$_[0];
  return 1 if $_[0] eq $_[1] and @s1 > uniq(@s1);
  my @s2 = split '',$_[1];
  return 0 if (join('',sort @s1) ne join('',sort @s2));
  (grep{$_ != 0} (pairwise{$a cmp $b} @s1,@s2)) == 2
}

printf "%d\n",buddy_strings('fuck','fcuk');
printf "%d\n",buddy_strings('love','love');
printf "%d\n",buddy_strings('fodo','food');
printf "%d\n",buddy_strings('feed','feed');

