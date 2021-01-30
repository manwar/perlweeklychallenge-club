#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( caesar('ABCDEFGHIJKLMNOPQRSTUVWXYZ',3),
           'XYZABCDEFGHIJKLMNOPQRSTUVW' );
is( caesar('THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG',3),
           'QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD' );

done_testing();

sub caesar {
  ## Use regex replace
  ##  r - return value rather than substitute in original string
  ##  e - evaluate replace rather than use string
  ##  g - repeat over all characters
  ##  x - not needed (comments in match) - but looks good!

  return $_[0] =~ s{([A-Z])}{chr 65+(-65-$_[1]+ord$1)%26}regex;

  ## Note about optimization of brackets in the eval function...
  ##
  ## 65 is at the front of the chr block as needing the bracket
  ##   for the %26 - it would be evaluated as the bracket wrapping
  ##   the parameters for chr ..{chr(...)+65}
  ##
  ## -65 is at the start of the bracket - to allow us to not
  ##   use brackets for the ord - if it was at the beginning
  ##   you would need ord as it would evaluate ord $1 - 65 .. as
  ##   ord( $1 - 65 - ...)
}

