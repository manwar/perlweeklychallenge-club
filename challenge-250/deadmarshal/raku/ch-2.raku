#!/usr/bin/env raku

sub alphanumeric_string_value(@arr)
{
  (@arr.map: {my $n = $_.Numeric !~~ Failure ?? (0+$_) !! .chars}).max
}

say alphanumeric_string_value(['perl','2','000','python','r4ku']);
say alphanumeric_string_value(['001','1','000','0001']);

