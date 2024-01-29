#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub split_strings{
  my ($arr,$sep) = @_;
  grep {length} map{split /\Q$sep\E/} @$arr
}

print show split_strings(['one.two.three','four.five','six'],'.');
print show split_strings(['$perl$$', '$$raku$'],'$');

