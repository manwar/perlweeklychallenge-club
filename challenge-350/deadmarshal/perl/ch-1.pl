#!/usr/bin/env perl
use strict;
use warnings;

sub good_substrings{
  scalar grep {!/(.).*\1/} $_[0] =~ /(?=(...))/g
}

printf "%d\n",good_substrings('abcaefg');
printf "%d\n",good_substrings('xyzzabc');
printf "%d\n",good_substrings('aababc');
printf "%d\n",good_substrings('qwerty');
printf "%d\n",good_substrings('zzzaaa');

