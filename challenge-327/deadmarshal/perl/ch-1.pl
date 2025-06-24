#!/usr/bin/env perl
use strict;
use warnings;
use Set::Scalar;
use feature qw(say);

sub missing_integers{
  Set::Scalar->new(@{$_[0]}) / Set::Scalar->new(1..@{$_[0]})
}

say missing_integers([1,2,1,3,2,5]);
say missing_integers([1,1,1]);
say missing_integers([2,2,1]);

