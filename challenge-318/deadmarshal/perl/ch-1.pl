#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub group_position{
  my @ret;
  push @ret,$1.$2 while($_[0] =~ m/(.)(\1{2,})/g);
  @ret
}

print show group_position('abccccd');
print show group_position('aaabcddddeefff');
print show group_position('abcdd');

