#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(all);

sub is_reversible_number{
  my ($n) = @_;
  return all {$_ % 2 != 0} (split //, $n + reverse $n);
}

my $i = 1;
while($i < 100){
  print "$i " if is_reversible_number($i);
  $i++;
}
