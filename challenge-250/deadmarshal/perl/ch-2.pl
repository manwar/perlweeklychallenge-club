#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max);

sub alphanumeric_string_value{
  max map{my $n = (/^\d+$/) ? $_ : length}@{$_[0]};
}

printf "%d\n",alphanumeric_string_value(['perl','2','000','python','r4ku']);
printf "%d\n",alphanumeric_string_value(['001','1','000','0001']);

