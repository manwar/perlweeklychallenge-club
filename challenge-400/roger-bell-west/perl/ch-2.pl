#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

sub minimumgeneticmutation($from, $to, $bank) {
  if ($from eq $to) {
    return 0;
  }
  my %paths;
  my @nodes = @{$bank};
  push @nodes, $from;
  foreach my $a (0 .. $#nodes - 2) {
    foreach my $b ($a + 1 .. $#nodes) {
      my $delta = 0;
      foreach my $c (0 .. length($nodes[$a]) - 1) {
        if (substr($nodes[$a], $c, 1) ne substr($nodes[$b], $c, 1)) {
          $delta += 1;
          if ($delta > 1) {
            last;
          }
        }
      }
        if ($delta == 1) {
          push @{$paths{$nodes[$a]}}, $nodes[$b];
          push @{$paths{$nodes[$b]}}, $nodes[$a];
        }
    }
  }
  my %seen;
  my @queue;
  push @queue, [$from, 0];
  while (scalar @queue > 0) {
    my ($gene, $depth) = @{shift @queue};
    if ($gene eq $to) {
      return $depth;
    }
    if (exists $paths{$gene}) {
      my %sseen = %seen;
      my $d = $depth + 1;
      foreach my $g (@{$paths{$gene}}) {
        unless (exists $seen{$g}) {
          push @queue, [$g, $d];
          $sseen{$g} = 1;
        }
      }
      %seen = %sseen;
    }
  }
  -1
}

use Test::More tests => 5;

is(minimumgeneticmutation('AACCGGTT', 'AACCGGTA', ['AACCGCTA', 'AAACGGTA']), -1, 'example 1');
is(minimumgeneticmutation('AACCGGTT', 'AACCGGAA', ['AACCGGTA', 'AACCGGAA', 'AACCGCTA', 'AACCCTAA', 'AACCGTAA']), 2, 'example 2');
is(minimumgeneticmutation('AAAAAAAA', 'AAAAACCC', ['CAAAAAAA', 'CCAAAAAA', 'AAAAAAAC']), -1, 'example 3');
is(minimumgeneticmutation('GAAAAAAA', 'GCCCCCCC', ['GCAAAAAA', 'GCCAAAAA', 'GCCCAAAA', 'GCCCCAAA', 'GCCCCCAA', 'GCCCCCCA', 'GCCCCCCC']), 7, 'example 4');
is(minimumgeneticmutation('AACCGGTT', 'AACCGGTT', ['AACCGGTA']), 0, 'example 5');
