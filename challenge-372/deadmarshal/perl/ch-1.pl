#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub rearrange_spaces{
  my $c = $_[0] =~ tr/ //;
  my @words = split ' ',$_[0];
  my $width = @words > 1 ? int($c / $#words) : 0;
  my $rest = @words > 1 ? $c % $#words : $c;
  join(' ' x $width,@words) . ' ' x $rest
}

is rearrange_spaces('  challenge  '),'challenge    ','Example 1';
is rearrange_spaces('coding  is  fun'),'coding  is  fun','Example 2';
is rearrange_spaces('a b c  d'),'a b c d ','Example 3';
is rearrange_spaces('  team      pwc  '),
  'team          pwc','Example 4';
is rearrange_spaces('   the  weekly  challenge  '),
  'the    weekly    challenge ','Example 5';

