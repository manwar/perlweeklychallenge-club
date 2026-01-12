#!/usr/bin/env perl
#
=head1 Task 2: Who Wins

Submitted by: Simon Green

It's NFL playoff time. Since the 2020 season, seven teams from each of the
league's two conferences (AFC and NFC) qualify for the playoffs based on
regular season winning percentage, with a tie-breaking procedure if required.
The top team in each conference receives a first-round bye, automatically
advancing to the second round. The following games are played. Some times the
games are played in a different order. To make things easier, assume the order
is always as below.

    Week 1: Wild card playoffs

        - Team 1 gets a bye

        - Game 1: Team 2 hosts Team 7

        - Game 2: Team 3 hosts Team 6

        - Game 3: Team 4 hosts Team 5

    - Week 2: Divisional playoffs

        - Game 4: Team 1 hosts the third seeded winner from the previous week.

        - Game 5: The highest seeded winner from the previous week hosts the second seeded winner.

    - Week 3: Conference final

        - Game 6: The highest seeded winner from the previous week hosts the other winner

You are given a six character string containing only H (home) and A away which
has the winner of each game. Which two teams competed in the the conference
final and who won?

=head2 Example 1

    NFC Conference 2024/5. Teams were Detroit, Philadelphia, Tampa Bay, Los Angeles
    Rams, Minnesota, Washington and Green Bay. Philadelphia - seeded second - won.

    Input: $results = "HAHAHH"
    Output: "Team 2 defeated Team 6"

    In Week 1,

        Team 2 (home) won against Team 7,

        Team 6 (away) defeated Team 3 and

        Team 4 (home) were victorious over Team 5.

        This means the second week match ups are
        Team 1 at home to Team 6, and Team 2 hosted Team 4.

    In week 2,

        Team 6 (away) won against Team 1, while

        Team 2 (home) beat Team 4.

        The final week was Team 2 hosting Team 6

    In the final week,

        Team 2 (home) won against Team 6.

=head2 Example 2

    AFC Conference 2024/5. Teams were Kansas City, Buffalo, Baltimore, Houston, Los
    Angeles Charges, Pittsburgh and Denver. Kansas City - seeded first - won.

    Input: $results = "HHHHHH"
    Output: "Team 1 defeated Team 2"

=head2 Example 3

    AFC Conference 2021/2. Teams were Tennessee, Kansas City, Buffalo, Cincinnati,
    Las Vegas, New England and Pittsburgh. Cincinnati - seeded fourth - won.

    Input: $results = "HHHAHA"
    Output: "Team 4 defeated Team 2"

=head2 Example 4

    NFC Conference 2021/2. Teams were Green Bay, Tampa Bay, Dallas, Los Angeles
    Rams, Arizona, San Francisco and Philadelphia. The Rams - seeded fourth - won.

    Input: $results = "HAHAAH"
    Output: "Team 4 defeated Team 6"

=head2 Example 5

    NFC Conference 2020/1. Teams were Green Bay, New Orleans, Seattle, Washington,
    Tampa Bay, Los Angeles Rams and Chicago. Tampa Bay - seeded fifth - won.

    Input: $results = "HAAHAA"
    Output: "Team 5 defeated Team 1"

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    ["HAHAHH", "Team 2 defeated Team 6", "Example 1"],
    ["HHHHHH", "Team 1 defeated Team 2", "Example 2"],
    ["HHHAHA", "Team 4 defeated Team 2", "Example 3"],
    ["HAHAAH", "Team 4 defeated Team 6", "Example 4"],
    ["HAAHAA", "Team 5 defeated Team 1", "Example 5"],
];

sub who_wins
{
    my $results = shift;

    my %games = (
        # week 1
        1 => [2, 7],
        2 => [3, 6],
        3 => [4, 5],
        4 => [1, ],
    );
    # week 1
    my @winners;
    $winners[0] = $games{1}->[substr($results, 0, 1) eq 'H' ? 0 : 1];
    $winners[1] = $games{2}->[substr($results, 1, 1) eq 'H' ? 0 : 1];
    $winners[2] = $games{3}->[substr($results, 2, 1) eq 'H' ? 0 : 1];

    # week 2
    my @wsort = sort {$a <=> $b} @winners;
    $games{4}->[1] = $wsort[2];
    $winners[3] = $games{4}->[substr($results, 3, 1) eq 'H' ? 0 : 1];

    $games{5} = [@wsort[0, 1]];
    $winners[4] = $games{5}->[substr($results, 4, 1) eq 'H' ? 0 : 1];

    # week 3
    $games{6} = [sort {$a <=> $b} @winners[3, 4]];
    $winners[5] = $games{6}->[substr($results, 5, 1) eq 'H' ? 0 : 1];

    my $l = $games{6}->[substr($results, 5, 1) eq 'A' ? 0 : 1];

    return "Team $winners[5] defeated Team $l";
}

for (@$cases) {
    is(who_wins($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
