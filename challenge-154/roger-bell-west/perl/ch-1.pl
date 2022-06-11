#! /usr/bin/perl

use strict;
use warnings;

use Algorithm::Permute;

use Test::More tests => 1;

is_deeply(missingpermutations(
  ["PELR", "PREL", "PERL", "PRLE", "PLER", "PLRE", "EPRL", "EPLR",
   "ERPL", "ERLP", "ELPR", "ELRP", "RPEL", "RPLE", "REPL", "RELP",
   "RLPE", "RLEP", "LPER", "LPRE", "LEPR", "LRPE", "LREP"]
    ),["LERP"],'example 1');

sub missingpermutations {
  my $list=shift;
  my $p=Algorithm::Permute->new([split '',$list->[0]]);
  my %perms;
  while (my @r=$p->next) {
    $perms{join('',@r)}=1;
  }
  map {delete $perms{$_}} @{$list};
  return [keys %perms];
}
