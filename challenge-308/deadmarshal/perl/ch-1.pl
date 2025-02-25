#!/usr/bin/env perl
use strict;
use warnings;

sub count_common{
  my %h;
  $h{$_}++ for @{$_[0]};
  scalar grep{exists $h{$_} && $h{$_}++ < 2} @{$_[1]}
}

printf "%d\n",count_common(['perl','weekly','challenge'],
			   ['raku','weekly','challenge']);
printf "%d\n",count_common(['perl','raku','python'],
			   ['python','java']);
printf "%d\n",count_common(['guest','contribution'],
			   ['fun','weekly','challenge']);

