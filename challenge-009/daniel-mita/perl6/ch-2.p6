#!/usr/bin/env perl6
use v6;

my %*SUB-MAIN-OPTS = :named-anywhere;

subset ScoreList of List where { .elems > 1 && $_ %% 2 && .[1,3…*].all ~~ Numeric };

#| "1224" Ranking.
multi MAIN (
  Bool :standard(:$s), #= Use Standard Ranking. Default if no ranking is provided.
  *@scores where * ~~ ScoreList,
) {
  my %table = create-table(@scores);
  for %table.keys.sort(&infix:«<=>»).reverse -> $score {
    state $place = 1;
    "$place: $_".say for %table{$score}.values.sort;
    $place += %table{$score}.elems;
  }
}

#| "1334" Ranking.
multi MAIN (
  Bool :modified(:$m)! where *.so, #= Use Modified Ranking.
  *@scores where * ~~ ScoreList,
) {
  my %table = create-table(@scores);
  for %table.keys.sort(&infix:«<=>»).reverse -> $score {
    state $place;
    $place += %table{$score}.elems;
    "$place: $_".say for %table{$score}.values.sort;
  }
}

#| "1223" Ranking.
multi MAIN (
  Bool :dense(:$d)! where *.so,  #= Use Dense Ranking.
  *@scores where * ~~ ScoreList, #= An even list of alternating names and scores. Higher score ranks higher.
) {
  my %table = create-table(@scores);
  for %table.keys.sort(&infix:«<=>»).reverse -> $score {
    state $place = 1;
    "$place: $_".say for %table{$score}.values.sort;
    $place++;
  }
}

multi GENERATE-USAGE (
  &main,
  Bool :standard(:$s),
  Bool :modified(:$m),
  Bool :dense(:$d) where { none(.one, .none) given @($s, $m, $d) },
) {
  "Error: Cannot use more than one rank type.\n\n" ~ GENERATE-USAGE(&main);
}

multi GENERATE-USAGE(&main, |) {
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

sub create-table (Array $_) {
  my %table;
  %table{.[1]}.push(.[0]) for .rotor(2);
  return %table;
}
