#!/usr/bin/env perl
use strict;
use warnings;
use Set::Scalar;

sub good_strings
{
  my $sum = 0;
  my $s1 = Set::Scalar->new(split '', $_[1]);
  map{
    my $s2 = Set::Scalar->new(split '',$_);
    $sum += length($_) if $s2->difference($s1)->is_null;
  } @{$_[0]};
  $sum
}

printf "%d\n", good_strings(['cat','bt','hat','tree'],'atach');
printf "%d\n", good_strings(['hello','world','challenge'],
			    'welldonehopper');

