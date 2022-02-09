#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my $input = shift // '1 | 2 3 | 4 5';
my @levels = map { [ split m{\s+}mxs ] } split m{\s*\|\s*}mxs, $input;
for my $depth (1 .. $#levels) {
   for my $i (0 .. $levels[$depth - 1]->$#*) {
      next if $levels[$depth - 1][$i] eq '*'
         || ($levels[$depth][$i * 2] // '*') ne '*'
         || ($levels[$depth][$i * 2 + 1] // '*') ne '*';
      say $depth;
      exit 0;
   }
}
say scalar @levels;
exit 0;
