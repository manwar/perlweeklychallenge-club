#!/usr/bin/env perl
use strict;
use warnings;

sub count_common{
  my %h;
  $h{$_}++ foreach @{$_[0]},@{$_[1]};
  (grep{$_ == 2}values %h) // 0
}

printf "%d\n",
  count_common(['Perl','is','my','friend'],
	       ['Perl','and','Raku','are','friend']);
printf "%d\n",
  count_common(['Perl','and','Python','are','very','similar'],
	       ['Python','is','top','in','guest','languages']);
printf "%d\n",
  count_common(['Perl','is','imperative','Lisp','is','functional'],
	       ['Crystal','is','similar','to','Ruby']);

