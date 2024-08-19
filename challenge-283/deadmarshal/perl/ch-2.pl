#!/usr/bin/env perl
use strict;
use warnings;
use List::MoreUtils qw(all frequency);

sub digit_count_value{
  my ($i,%h) = (0,frequency(@{$_[0]}));
  all{($h{$i++} // 0) == $_} @{$_[0]}
}

printf "%d\n",digit_count_value([1,2,1,0]);
printf "%d\n",digit_count_value([0,3,0]);

