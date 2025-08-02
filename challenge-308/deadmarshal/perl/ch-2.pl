#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub decode_xor{
  my @res = ($_[1]);
  push @res,$res[-1] ^ $_ foreach @{$_[0]};
  @res
}

print show decode_xor([1,2,3],1);
print show decode_xor([6,2,7,3],4);

