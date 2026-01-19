#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @playoffs = (
    "HAHAHH",
    "HHHHHH",
    "HHHAHA",
    "HAHAAH",
    "HAAHAA"
);

print("\n");
foreach my $playoff (@playoffs){
    my ($won, $defeated) = compute_playoff_winner($playoff);

    printf(
        "Input: \$results = \"%s\"\nOutput: \"Team %d defeated Team %d\"\n\n",
        $playoff,
        $won,
        $defeated
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine the teams (and ultimate victor) that play in a NFL conference final
# game, where the playoff consists of six games including the final game, with
# the teams that play in each game defined as follows:
#
# First week- Wildcard Playoffs:
#   * The 1st seeded team gets a bye and does not play this week
#   * Game 1: The 2nd seeded team hosts the 7th
#   * Game 2: The 3rd seeded team hosts the 6th
#   * Game 3: The 4th seeded team hosts the 5th
#
# Second week- Divisional Playoffs
#   * Game 4: The 1st seeded team hosts the lowest-seeded winner from the first
#     week
#   * Game 5: The highest seeded winner from the first week hosts the second
#     seeded winner
#
# Third week- Conference Final
#   * Game 6: The highest seeded winner from the second week hosts the other
#     winner; the victor is the conference champion
#
# Takes one argument:
# * A six-character string that contains only 'H' for a home/hosting team
#   victory, or 'A' for an away team victory in each of the six games in the
#   sequence defined above (e.g. "HAHAAH")
# Returns:
# * A list containing the two seeds of the teams that played in the final game,
#   with the victor's seed appearing first (e.g. (4, 6) )
################################################################################
sub compute_playoff_winner{
    my $games = shift();

    my @outcomes;
    my $i = 0;

    # Set up a table of Week One matchups by seed (higher
    # values are lower seeds) and convert it into a list of
    # outcomes, then sort these in descending order (lowest
    # seed first); the hosting team appears first within
    # each row of the initial table
    @outcomes = sort(
        { $b <=> $a }
        map(
            $_->[ substr($games, $i++, 1) eq "H" ? 0 : 1 ],
            (
                [ 2, 7 ],
                [ 3, 6 ],
                [ 4, 5 ]
            )
        )
    );

    # Set up a table of Week Two matchups, then convert
    # them into a list of results, arranging these in
    # ascending order (highest seed first) so the
    # hosting team in the final game comes first
    @outcomes = map(
        $_->[ substr($games, $i++, 1) eq "H" ? 0 : 1 ],
        (
            [ 1,            $outcomes[0] ],
            [ $outcomes[2], $outcomes[1] ]
        )
    );
    @outcomes = ($outcomes[1], $outcomes[0])
        if($outcomes[0] > $outcomes[1]);

    return(
        # Directly compute the outcome of the final game, and
        # report the winner and loser, in that order
        substr($games, 5, 1) eq "H" ?
            @outcomes
            :
            ($outcomes[1], $outcomes[0])
    );

}



