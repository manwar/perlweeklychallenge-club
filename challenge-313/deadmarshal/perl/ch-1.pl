#!/usr/bin/env perl
use strict;
use warnings;
use Set::Scalar;

sub broken_keys{
  my $s1 = Set::Scalar->new(split '',$_[0]);
  my $s2 = Set::Scalar->new(split '',$_[1]);
  $s1 <= $s2
}

printf "%d\n",broken_keys('perl','perrrl');
printf "%d\n",broken_keys('raku','rrakuuuu');
printf "%d\n",broken_keys('python','perl');
printf "%d\n",broken_keys('coffeescript','cofffeescccript');

