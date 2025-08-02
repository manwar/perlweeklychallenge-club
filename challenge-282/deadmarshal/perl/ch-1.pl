#!/usr/bin/env perl
use strict;
use warnings;

sub good_integer {
  $_[0] =~ /(\d)\1{2}(\1)?/ ? ($2 ? -1 : $1 x 3) : ()
}

print good_integer(12344456),"\n";
print good_integer(1233334),"\n";
print good_integer(10020003),"\n";

