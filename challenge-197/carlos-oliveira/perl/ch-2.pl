use strict;
use warnings;
use 5.36.0;
use Data::Dump;


sub wiggle;


dd wiggle 1,5,1,1,6,4;
dd wiggle 1,3,2,2,3,1;
dd wiggle 9,8,7,6,5,4,3,2,1;


sub wiggle {
  my $originalLength = @_;
  @_ = sort @_;
  my $offset = int @_ / 2;
  my @pivots = splice @_, -$offset, $offset;

  for my $i ( reverse 1 .. $#_ + ($originalLength % 2 == 0) ) {
    my $pivot = pop @pivots;
    splice @_, $i, 0, $pivot;
  }

  return @_;
}
