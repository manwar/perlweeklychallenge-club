#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( first_value pairwise );

sub whoWinsTuples($results, $tuples) {
  return sort @{[ pairwise {
    my ($home, $away) = @$b;
    $a eq 'H' ? $home : $away
  } @{[split //, $results]}, @$tuples ]};
}

sub whoWins($results) {
  # week 1
  my $tuples = [[2,7], [3,6], [4,5]];
  my @winners = whoWinsTuples(substr($results, 0, 3), $tuples);
  substr($results, 0, 3) = ''; # remove the first 3 results
  my $lowest = pop @winners;

  # week 2
  $tuples = [[1, $lowest], [ @winners ] ];
  @winners = whoWinsTuples(substr($results, 0, 2), $tuples);
  substr($results, 0, 2) = ''; # remove the next 2 results

  # week 3
  $tuples = [ [ @winners ], ];
  @winners = whoWinsTuples($results, $tuples);

  my $win  = $winners[0];
  my $loss = first_value { $_ != $win } @{$tuples->[0]};
  return "Team $win defeated Team $loss";
}

sub solution($results) {
  say qq{Input: \$results = "$results"};
  say 'Output: ' . whoWins($results);
}

say "Example 1:";
solution("HAHAHH");

say "\nExample 2:";
solution("HHHHHH");

say "\nExample 3:";
solution("HHHAHA");

say "\nExample 4:";
solution("HAHAAH");

say "\nExample 5:";
solution("HAAHAA");

