#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say state);
use Test::More;

my @rare_ends = ( [2,[2]], [4,[0]], [6,[0,5]], [8,[2,3,7,8]] );

is( "@{[ rare_numbers( 2  ) ]}", '65' );
is( "@{[ rare_numbers( 6  ) ]}", '621770' );
is( "@{[ rare_numbers( 9  ) ]}", '281089082' );
#is( "@{[ rare_numbers( 10 ) ]}", "2022652202 2042832002" );

done_testing();


sub rare_numbers {
  my $size = shift;
  my @ret;
  my $y;
  foreach( 10**($size-1) .. 10**$size - 1 ) {
    $y = reverse $_;
    push @ret, $_ if $_ > $y && ($_-$y) == (int sqrt($_-$y))**2 && ($_+$y) == (int sqrt($_+$y))**2;
  }
  return @ret;
}

