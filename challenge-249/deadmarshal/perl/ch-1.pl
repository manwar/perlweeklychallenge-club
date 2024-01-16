#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(all);
use Data::Show;

sub equal_pairs{
  my %h;
  $h{$_}++ foreach @{$_[0]};
  (all{$_%2} values %h) ? () : map{my $k=$_;map{[$k,$k]}1..$h{$k}/2}keys %h;
}

print show equal_pairs([3,2,3,2,2,2]);
print show equal_pairs([1,2,3,4]);

