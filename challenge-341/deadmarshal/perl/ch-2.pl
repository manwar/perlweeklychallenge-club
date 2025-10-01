#!/usr/bin/env perl
use strict;
use warnings;

sub reverse_prefix{
  my ($str) = @_;
  $str =~ s/^(.*?$_[1])/reverse $1/e;
  $str
}

printf "%s\n",reverse_prefix('programming','g');
printf "%s\n",reverse_prefix('hello','h');
printf "%s\n",reverse_prefix('abcdefghij','h');
printf "%s\n",reverse_prefix('reverse','s');
printf "%s\n",reverse_prefix('perl','r')

