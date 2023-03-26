#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @ACC = (
 [ ['A', 'a1@a.com', 'a2@a.com'],
   ['B', 'b1@b.com'],
   ['A', 'a3@a.com', 'a1@a.com'] ],
 [ ['A', 'a1@a.com', 'a2@a.com'],
   ['B', 'b1@b.com'],
   ['A', 'a3@a.com'],
   ['B', 'b2@b.com', 'b1@b.com'] ],
 [ ['A', 'a1@a.com', 'a2@a.com'],
   ['A', 'a3@a.com', 'a4@a.com'],
   ['A', 'a2@a.com', 'a4@a.com'] ],
 [ ['A', 'a1@a.com', 'a2@a.com'],
   ['A', 'a2@a.com', 'a3@a.com'],
   ['A', 'a3@a.com', 'a4@a.com'],
   ['A', 'a4@a.com', 'a5@a.com'],
   ['A', 'a5@a.com', 'a6@a.com'] ],
 [ ['A', 'a1@a.com', 'a2@a.com'],
   ['A', 'a3@a.com', 'a4@a.com'],
   ['A', 'a5@a.com', 'a6@a.com'],
   ['A', 'a7@a.com', 'a8@a.com'],
   ['A', 'a1@a.com', 'a3@a.com'],
   ['A', 'a5@a.com', 'a7@a.com'],
   ['A', 'a1@a.com', 'a5@a.com'] ],
);

say Dumper(merge_accounts( $_ )) for @ACC;

sub merge_accounts {
  my($in,$out,%seen,$t) = ([],shift);
  while(@{$out}!=@{$in}) {
    ($in,$out,%seen) = ($out,[]);
    O: for my $acc (@{$in}) {
      my( $name, @e )=@{ $acc };
      for(@e) {
        if( exists $seen{$_} ) {
          my( $m, @f ) = @{ $out->[ $t = $seen{$_} ] };
          my %T        = map { $_=>1 } @e, @f;
          $seen{$_}    = $t for keys %T;
          $out->[ $t ] = [ $m, keys %T ];
          next O;
        }
      }
      $seen{$_} = @{$out} for @e;
      push @{$out},$acc;
    }
  }
  $out
}
