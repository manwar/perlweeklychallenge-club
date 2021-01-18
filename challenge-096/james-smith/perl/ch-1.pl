#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

is( rev_words('The Weekly Challenge'), 'Challenge Weekly The' );
is( rev_words('    Perl and   Raku are  part of the same family  '), 'family same the of part are Raku and Perl' );

done_testing();

sub rev_words {
  return join q( ), grep {$_} reverse split m{\s+}, $_[0];
}

