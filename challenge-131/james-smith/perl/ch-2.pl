#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @player_ages = (
  [20, "Alex"  ],
  [28, "Joe"   ],
  [38, "Mike"  ],
  [18, "Alex"  ],
  [25, "David" ],
  [18, "Simon" ],
);

my @player_names = (
  ["Alex", "Stewart"],
  ["Joe",  "Root"   ],
  ["Mike", "Gatting"],
  ["Joe",  "Blog"   ],
  ["Alex", "Jones"  ],
  ["Simon","Duane"  ],
);

my $MAX = @ARGV ? $ARGV[0] : 4;

my @res;
while( my @pns = splice @player_names, 0, $MAX ) {
  my %cache = ();
  push @{$cache{$_->[0]}},$_->[1] foreach @pns;
  foreach my $p (@player_ages) {
    push @res, [$p->[0], $p->[1], $_] foreach @{$cache{$p->[1]}};
  }
}
printf "%4d\t%-20s\t%-20s\n", @{$_} foreach @res;

