#!/usr/bin/env perl
use strict;
use warnings;
use List::MoreUtils qw(uniq);

sub string_compression{
  my @chars = split '',$_[0];
  my ($ret,%h) = ('');
  $h{$_}++ foreach @chars;
  map{$ret .= $h{$_} == 1 ? $_ : $h{$_} . $_} uniq @chars;
  $ret
}

printf "%s\n",string_compression("abbc");
printf "%s\n",string_compression("aaabccc");
printf "%s\n",string_compression("abcc");

