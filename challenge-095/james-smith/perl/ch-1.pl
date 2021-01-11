#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( is_palindrome_rev(1221), 1 );
is( is_palindrome_rev(-101), 0 );
is( is_palindrome_rev(90),   0 );

is( is_palindrome_array(1221), 1 );
is( is_palindrome_array(-101), 0 );
is( is_palindrome_array(90),   0 );

done_testing();

sub is_palindrome_rev {
  return ( $_[0] eq reverse $_[0]) ? 1 : 0;
}

sub is_palindrome_array {
  my $n = shift;
  return 0 if $n < 0;
  my @digits  = $n%10;
  push @digits, $n%10 while $n = int ($n/10);
  while (@digits>1) {
    return 0 if shift @digits != pop @digits;
  }
  return 1;
}

