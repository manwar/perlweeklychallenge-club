#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;
use Set::Scalar;

sub missing_members{
  my $s1 = Set::Scalar->new(@{$_[0]});
  my $s2 = Set::Scalar->new(@{$_[1]});
  [($s1-$s2)->members],[($s2-$s1)->members]
}

print show missing_members([1,2,3],[2,4,6]);
print show missing_members([1,2,3,3],[1,1,2,2]);

