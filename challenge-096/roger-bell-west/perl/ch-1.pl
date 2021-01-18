#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(rw('The Weekly Challenge'),'Challenge Weekly The','example 1');
is(rw('    Perl and   Raku are  part of the same family  '),'family same the of part are Raku and Perl','example 2');

sub rw {
  my $n=shift;
  return join(' ',reverse split ' ',$n);
}
