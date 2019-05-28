#!/usr/bin/env perl6

# Each of the ranking functions assumes a List of Pairs with scores as values,
# and outputs the ranked scores as a sorted list of pairs.

# Sample data according to these assumptions.  Roll a d10 for score.

my %scores = <Andrea Charis Coleman Denita Gale Georgina Glinda Isidra Jolyn
              Kori Lenore Marcia Micha Mose Myriam Rachele Reginald Romona
              Rosita Shoshana> Z=> (1...10).roll(*);

enum RankMode <rank-standard rank-modified rank-dense>;

my proto rank($, RankMode, &?) { * }

# 1224 style ranking.
my multi rank(@scores where { $_».?value.all ~~ Int },
              rank-standard,
              &ranking = {$^b.key <=> $^a.key}) {
  my $n = 1; # Start at 1 for first rank
  my @out;

  # Convert Name => Score Pairs to a hash of lists of names, keyed by score, and
  # append to output array.
  for Hash.new.append(@scores.invert).pairs.sort(&ranking) {
    # Invert the Pair again to append a list of (rank => (name => score));
    @out.append: .invert.map({$n => $_ });
    $n += .value.elems; # Increase rank only after appending values.
  };

  @out;
}

# 1334 style ranking
my multi rank(@scores where { $_».?value.all ~~ Int },
              rank-modified,
              &ranking = {$^b.key <=> $^a.key}) {
  my $n = 0; # Start at zero as we add the rank before appending
  my @out;

  # Convert Name => Score Pairs as above.
  for Hash.new.append(@scores.invert).pairs.sort(&ranking) {
    $n += .value.elems; # Increase rank before appending values.
    @out.append: .invert.map({$n => $_ });
  };

  @out;
}

# 1223 style ranking
my multi rank(@scores where { $_».?value.all ~~ Int },
              rank-dense,
              &ranking = {$^b.key <=> $^a.key}) {
  my $n = 1; # Start at 1 for first rank
  my @out;

  # Convert Name => Score Pairs as above.
  for Hash.new.append(@scores.invert).pairs.sort(&ranking) {
    @out.append: .invert.map({$n => $_ });
    $n++; # Invert rank after appending values, but only by one.
  };

  @out;
}

# Dispatch for a Hash.
my multi rank(%scores, RankMode $mode, &ranking = {$^b.key <=> $^a.key}) {
  rank(%scores.pairs, $mode, &ranking);
}

say 'Standard:';
rank(%scores, rank-standard)».say;

say 'Modified:';
rank(%scores, rank-modified)».say;

say 'Dense:';
rank(%scores, rank-dense)».say;
