#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( caesar('ABCDEFGHIJKLMNOPQRSTUVWXYZ',3), 'XYZABCDEFGHIJKLMNOPQRSTUVW' );
is( caesar('THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG',3), 'QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD' );

done_testing();

sub caesar {
  return join q(), map { m{[A-Z]} ? chr 65+(ord($_)-65-$_[1])%26 : $_ } split m{}, $_[0];
}

