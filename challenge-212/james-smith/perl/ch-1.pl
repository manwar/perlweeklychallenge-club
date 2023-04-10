#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
  [ ['Perl',2,22,19,9], 'Raku' ],
  [ ['Raku',24,4,7,17], 'Perl' ],
);


sub jumping_letters {
                         # Stitch back into word
  return join '',
                         # Like ord below chr acts on $_ if no parameters
                         # are passed...
         map { chr }
                         # Do the maths.... now this is where things get
                         # a little cheeky.... ord acts on $_ which is the
                         # letter, shift returns the next value of @_ which
                         # is the shift!
                         # 96&ord| .... preserves the 64 & 32 bit - it is
                         # the 32 represents upper or lowercase
                         # the 64 indicates that this is a letter (sort of)
                         # 31&ord removes these and returns the numeric
                         # position of the number in the alphabet - we subtract
                         # one to get the zero based position + shift it
                         # wrap and them move back to a one based position.
         map { (96&ord) | ( (31&ord) -1 + shift)%26 +1 }
                         # Split into individual letters;
         split //,
                         ## This is the word we are "changing"
         shift;
}

is( jumping_letters( @{$_->[0]} ), $_->[1] ) for @TESTS;
