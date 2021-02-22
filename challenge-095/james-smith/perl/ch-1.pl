#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( is_palindrome_rev(1221), 1 ); ## Even number of digits
is( is_palindrome_rev(-101), 0 ); ## -ve number
is( is_palindrome_rev(101),  1 ); ## Odd number of digits
is( is_palindrome_rev(90),   0 ); ## Not-palindromic

is( is_palindrome_array(1221), 1 );
is( is_palindrome_array(-101), 0 );
is( is_palindrome_array(101),  1 );
is( is_palindrome_array(90),   0 );

done_testing();

say is_palindrome_array($_,2), is_palindrome_array($_,3), is_palindrome_array($_,4), is_palindrome_array($_,6),' ',$_ foreach 6..1000000;
## I will provide two solutions here...

## (1) The first one just treating the two numbers as strings and
##      using reverse

sub is_palindrome_rev {
  return ( $_[0] eq reverse $_[0]) ? 1 : 0;
}

## (2) The second one just treating the two numbers as numbers and
##     using the % operator to split them into digits.
##     Notes:
##      * Push is more optimal than unshift - so the digit list I get
##        is in reverse order but that doesn't matter in this case
##      * Obviously -ve numbers will fail so deal with this first
##      * When the digits array has one element then we know the
##        remaining digits form a palindrome {we can't use the
##        shift/pop trick as it will compare digit with undef;

sub is_palindrome_array {
  my($n,$radix) = @_;
  $radix||=10;
  return 0 if $n < 0;
  my @digits  = $n%$radix;
  push @digits, $n%$radix while $n = int ($n/$radix);
  while( @digits>1 ) {
    return 0 if shift @digits != pop @digits;
  }
  return 1;
}

