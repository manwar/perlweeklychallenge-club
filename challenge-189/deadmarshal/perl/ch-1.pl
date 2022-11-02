#!/usr/bin/env perl
use strict;
use warnings;

sub greater_character{
  my ($arr, $target) = @_;
  @$arr = sort {$a cmp $b} @$arr;
  for(my $i = 0; $i < @$arr; ++$i){
    return $arr->[$i] if $arr->[$i] gt $target;
  }
  return $target;
}

print greater_character([qw/e m u g/], 'b'), "\n";
print greater_character([qw/d c e f/], 'a'), "\n";
print greater_character([qw/j a r/], 'o'), "\n";
print greater_character([qw/d c a f/], 'a'), "\n";
print greater_character([qw/t g a l/], 'v'), "\n";

