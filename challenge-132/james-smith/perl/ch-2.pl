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

## index of key columns...
my $ages_key      = 1;
my $names_key     = 0;

## Get non-key columns in the names table...
##   { get all column ids and splice out the key column}
my @names_columns = 0..(@{$player_names[0]}-1);
splice @names_columns, $names_key,1; ## Remove key....

## Get chunk size (default to 4)
my $MAX = @ARGV ? $ARGV[0] : 4;

my @res;

while( my @pns = splice @player_names, 0, $MAX ) {
  my %cache = ();
  ## Foreach we key on the key column, and store the non-key columns
  ##   Because key columns not unique we have array of arrays for
  ##   the hash values
  push @{$cache{$_->[$names_key]}},[ @{$_}[@names_columns] ] foreach @pns;

  ## Now loop through the array of ages.
  ## When we find a key we dump all values.
  ## We push all values in the ages table - and all values (except the key) of the names table
  foreach my $p (@player_ages) {
    push @res, [@{$p}, @{$_}] foreach @{$cache{$p->[$ages_key]}};
  }
}

## Just print values
say join "\t", map { sprintf '%-15s', $_ } @{$_} foreach @res;

