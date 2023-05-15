#!/usr/bin/env perl
use strict;
use warnings;

sub max_number{
  join '',sort {"$b$a" cmp "$a$b"} @{$_[0]};
}

printf "%s\n", max_number([1,23]);
printf "%s\n", max_number([10,3,2]);
printf "%s\n", max_number([31,2,4,10]);
printf "%s\n", max_number([5,11,4,1,2]);
printf "%s\n", max_number([1,10]);

