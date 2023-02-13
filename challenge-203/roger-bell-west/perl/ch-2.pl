#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use File::Find;

sub copydir($src, $dst) {
  my @ds;
  my $l = 1 + length($src);
  find(sub{
         if (-d $_) {
           push @ds,substr($File::Find::name, $l);
         }
       }, $src);
  foreach my $d (@ds) {
    if (defined $d && length($d) > 0) {
      mkdir "$dst/$d";
    }
  }
}

copydir('a/b/c', 'x/y');
