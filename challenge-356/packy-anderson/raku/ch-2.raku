#!/usr/bin/env raku
use v6;

sub whoWinsTuples($results, @tuples) {
  my @winners;
  for $results.comb Z @tuples -> [$result, @tuple] {
    my ($home, $away) = @tuple;
    @winners.push: ($result eq 'H' ?? $home !! $away);
  }
  return @winners.sort;
}

sub whoWins($results is copy) {
  # week 1
  my @tuples = [(2,7), (3,6), (4,5)];
  my @winners = whoWinsTuples($results.substr(0, 3), @tuples);
  $results.substr-rw(0, 3) = ''; # remove the first 3 results
  my $lowest = @winners.pop;

  # week 2
  @tuples = [(1, $lowest), @winners];
  @winners = whoWinsTuples($results.substr(0, 2), @tuples);
  $results.substr-rw(0, 2) = ''; # remove the next 2 results

  # week 3
  @tuples = [ [ @winners ], ];
  @winners = whoWinsTuples($results, @tuples);

  my $win  = @winners[0];
  my $loss = @tuples[0].grep({ $_ != $win }).first;
  return "Team $win defeated Team $loss";
}

sub solution($results) {
  say qq{Input: \$results = "$results"};
  say 'Output: ' ~ whoWins($results);
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
