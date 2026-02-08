#!/usr/bin/env perl
use strict;
use warnings;

sub string_reduction{
  my ($s) = @_;
  1 while $s =~ s/(\w)\1//g;
  $s
}

printf "%s\n",string_reduction('aabbccdd');
printf "%s\n",string_reduction('abccba');
printf "%s\n",string_reduction('abcdef');
printf "%s\n",string_reduction('aabbaeaccdd');
printf "%s\n",string_reduction('mississippi');

