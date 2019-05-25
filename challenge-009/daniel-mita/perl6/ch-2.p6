#!/usr/bin/env perl6
use v6;

my %*SUB-MAIN-OPTS = :named-anywhere;

multi MAIN (
  Bool :help(:$h)! where *.so, #= Print help.
  |,
) {
  say GENERATE-USAGE(&?ROUTINE);
}

multi MAIN (
  Bool :standard(:$s), #= Use Standard Ranking (1224). Default if no ranking is provided.
  Bool :dense(:$d),    #= Use Dense Ranking (1223).
  Bool :modified(:$m)  #= Use Modified Ranking (1334).
  where { any(.one, .none) given @($s, $m, $d) },
  *@scores where {
    .elems > 1 && $_ %% 2 && .[1,3…*].all ~~ Numeric
  }, #= An even list of alternating names with scores. Higher score ranks better.
) {
  my %table;
  %table{.[1]}.push(.[0]) for @scores.rotor(2);

  say join "\n", gather {
    for %table.keys.sort(&infix:«<=>»).reverse -> $score {
      state $rank = $m ?? 0 !! 1;                      # Start at 0 if modified, else 1
      $rank += %table{$score}.elems if $m;             # Add number of players at rank (modified)
      "$rank: $_".take for %table{$score}.values.sort; # Set all players at current rank
      $rank += %table{$score}.elems if none($m, $d);   # Next rank = players at current rank (standard)
      $rank++ if $d;                                   # Next rank is +1 (dense)
    }
  };
}

multi GENERATE-USAGE (
  &main,
  *@ where * !%% 2,
  |,
) {
  "Error:\n  Odd number of elements for scores.\n\n" ~ GENERATE-USAGE(&main);
}

multi GENERATE-USAGE (
  &main,
  Bool :standard(:$s),
  Bool :modified(:$m),
  Bool :dense(:$d) where { none(.one, .none) given @($s, $m, $d) },
  |,
) {
  "Error:\n  Cannot use more than one rank type.\n\n" ~ GENERATE-USAGE(&main);
}

multi GENERATE-USAGE (
  &main,
  |,
) {
  $*USAGE ~ q:to/DOC/;


    Example:
      perl6 ch-2.p6 --dense foo 3 bar 8 baz 1 fizz 3 buzz 6

      1: bar
      2: buzz
      3: fizz
      3: foo
      4: baz
    DOC
}
