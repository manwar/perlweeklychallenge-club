#!/usr/bin/env perl
use strict;
use warnings;
use ntheory qw(hammingweight);
use Data::Show;

sub sort_by_one_bits{
  sort{hammingweight($a) <=> hammingweight($b) || $a <=> $b} @{$_[0]}
}

print show sort_by_one_bits([0,1,2,3,4,5,6,7,8]);
print show sort_by_one_bits([1024,512,256,128,64]);

