#!/usr/bin/perl -w

use strict;
use feature 'say';
use Test::More tests => 5;

# In:
#   $games: string of 'H' or 'A' for each game played
#   @teams: list of pairs of seed numbers of playing teams, home team first
# @teams must have twice the number of teams as $games has characters.
# Out:
#   @teams but each pair is ordered with the winner first
sub playoff_week {
	my($games, @teams) = @_;
	#say "$games;", join(':', @teams);
	return map {
		my $i = $_ * 2;
		if (substr($games, $_, 1) eq 'H' ) {
			@teams[$i + 0, $i + 1];
		} else {
			@teams[$i + 1, $i + 0];
		}
	} (0 .. length($games) - 1);
}

# In:
#   list of pairs of seed numbers of playing teams, winner first
# Out:
#   list of winner seed numbers
# The output list will be half the size of the input list.
sub winners {
	# Even-numbered items are winners.
	return map { @_[$_ * 2] } (0 .. scalar(@_) / 2 - 1);
}

sub playoffs {
	my($games) = @_;

	# After the last round we need to know the loser as well, so we have
	# separate functions for playing the week and filtering out the losers.

	# Seeded team 2 plays team 7, team 3 plays team 6, team 4 plays team 5.
	# Seeded team 1 doesn't play this week.
	my @w1 = playoff_week(substr($games, 0, 3), (2, 7, 3, 6, 4, 5));
	#say join ':', @w1;
	@w1 = winners(@w1);
	#say join ':', @w1;

	# Seeded team 1 plays last seeded winner of week 1,
	# highest seeded winner of week 1 plays second seeded winner.
	my @w2 = playoff_week(substr($games, 3, 2), (1, (sort @w1)[2, 0, 1]));
	#say join ':', @w2;
	@w2 = winners(@w2);
	#say join ':', @w2;

	# Winners of week 2 play each other, first seeded team plays at home.
	my @w3 = playoff_week(substr($games, 5, 1), sort @w2);
	#say join ':', @w3;

	return "Team $w3[0] defeated Team $w3[1]";
}

is(playoffs("HAHAHH"), "Team 2 defeated Team 6", "Example 1");
is(playoffs("HHHHHH"), "Team 1 defeated Team 2", "Example 2");
is(playoffs("HHHAHA"), "Team 4 defeated Team 2", "Example 3");
is(playoffs("HAHAAH"), "Team 4 defeated Team 6", "Example 4");
is(playoffs("HAAHAA"), "Team 5 defeated Team 1", "Example 5");
done_testing();

