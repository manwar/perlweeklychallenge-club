#!/usr/bin/env perl
use strict;
use warnings;

sub separate_digits
{
  map{split ''} @{$_[0]};
}

printf "(%s)\n", join ",", separate_digits([1,34,5,6]);
printf "(%s)\n", join ",", separate_digits([1,24,51,60]);

