#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( rev_words('The Weekly Challenge'),
    'Challenge Weekly The' );
is( rev_words('    Perl and   Raku are  part of the same family  '),
    'family same the of part are Raku and Perl' );

done_testing();

## Nothing much to say here...
## split the string into words
## remove any "empty" strings {the one at the start!}
## reverse the order
## and stitch it back together....

sub rev_words {
  return join q( ), reverse grep {$_} split m{\s+}, $_[0];
}

