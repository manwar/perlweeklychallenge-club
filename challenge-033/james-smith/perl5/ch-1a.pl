#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
my %T;
while(<>) {
  $T{$_}++ foreach grep { /[a-z]/ } split m{}, lc $_;
}


say $_,': ',$T{$_}||0 foreach 'a'..'z';
