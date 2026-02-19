#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
356-2: Who Wins         Submitted by: Simon Green
It’s NFL playoff time. Since the 2020 season, seven teams from each of the league’s two conferences (AFC and NFC) qualify for the playoffs based on regular season winning percentage, with a tie-breaking procedure if required. The top team in each conference receives a first-round bye, automatically advancing to the second round.

The following games are played. Some times the games are played in a different order. To make things easier, assume the order is always as below.

Week 1: Wild card playoffs
    - Team 1 gets a bye
  - Game 1: Team 2 hosts Team 7
  - Game 2: Team 3 hosts Team 6
  - Game 3: Team 4 hosts Team 5
Week 2: Divisional playoffs
  - Game 4: Team 1 hosts the third seeded winner from the previous week.
  - Game 5: The highest seeded winner from the previous week hosts the
        second seeded winner.
Week 3: Conference final
  - Game 6: The highest seeded winner from the previous week hosts the
        other winner

You are given a six character string containing only H (home) and A away which has the winner of each game. Which two teams competed in the the conference final and who won?
=end comment

my @Test =
    # in        winner  2nd
    "HAHAHH",   2,      6,
    "HHHAHA",   4,      2,
    "HHHHHH",   1,      2,
    "HAHAAH",   4,      6,
    "HAAHAA",   5,      1,

    "AAAAAA",   7,      6,
    "AAAAAH",   6,      7,
    "AAAHHA",   5,      1,
    "HAAAAA",   6,      5,
    "AAHAAH",   6,      7,
    "AHAAAH",   5,      7,
    "HAAAAH",   5,      6,
    "AAAAAH",   6,      7,
;
plan @Test ÷ 3;

my regex playoff { ^ [ 'H' | 'A']**6 $  }

sub win-i( $c -->Int:D) { $c eq 'H' ?? 0 !! 1 }  

    # Xlate 1st three chars to week 2 pair ups.
my $wk2 =  Hash.new(
    'AAA', $[ [1, 7], [5, 6]], 'AAH', $[ [1, 7], [4, 6]],
    'AHA', $[ [1, 7], [3, 5]], 'AHH', $[ [1, 7], [3, 4]],
    'HAA', $[ [1, 6], [2, 5]], 'HAH', $[ [1, 6], [2, 4]],
    'HHA', $[ [1, 5], [2, 3]], 'HHH', $[ [1, 4], [2, 3]],
);

multi task( Str(Any)$a, 'FMT' -->Str:D) {
    my ( $champ, $second) = task( $a);
    "Input: \$results = \"$a\"\nOutput: \"Team $champ defeated Team $second\""
}

multi task( Str(Any)$a is copy where * ~~ / <playoff> / -->Array) {
    my %week2-pairing = $wk2.map({ .key => .value.clone });
    my $wk-pr = %week2-pairing{$a.substr(0,3)};
    my @home-q  = $a.substr(3).comb;
            # resolve first week's games
    for  ^@home-q.end -> \i {
        $wk-pr[i] =  $wk-pr[i][win-i( @home-q[i])];
    }
            # resolve & report [ $champ, $runner-up]
    $wk-pr = [
        flat($wk-pr.sort).[ win-i(@home-q.tail), !win-i(@home-q.tail) ]
    ];
}

for @Test -> $in, $ace, $deuce {
   is task(    $in), [$ace, $deuce], "$ace, $deuce <- $in.raku()";
}
done-testing;

my $results = "HAHAHH";
say "\n" ~ task($results, 'FMT');

=finish
format example:
Input: $results = "HHHHHH"
Output: "Team 1 defeated Team 2"
