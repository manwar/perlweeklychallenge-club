#!/usr/bin/env perl
use strict;
use warnings;

sub count_even_digits_number{
  scalar grep{(split'',$_)%2==0}@{$_[0]}
}

printf "%d\n",count_even_digits_number([10,1,111,24,1000]);
printf "%d\n",count_even_digits_number([111,1,11111]);
printf "%d\n",count_even_digits_number([2,8,1024,256]);

