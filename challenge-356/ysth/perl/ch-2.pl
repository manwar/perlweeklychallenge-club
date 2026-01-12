use 5.036;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-355/#TASK2

# true if integers in ints monotonically increase then decrease
sub who_wins($game_results) {
    # teams in seeded order
    # each game eliminates one team, ending with the final winner, so there is one more team than games
    my @teams = 1..(1 + length $game_results);
    my @game_results = split //, $game_results;

    while (@teams > 2) {
        # resolve games
        # if an odd number of teams remain, highest seeded team gets a bye
        my $home = @teams % 2;
        # pair them: first seeded team remaining to play hosts last seeded team remaining to play
        my $away = $#teams;
        for (1..(@teams / 2)) {
            if ('H' eq shift @game_results) {
                splice @teams, $away, 1;
                ++$home; --$away;
            }
            else {
                splice @teams, $home, 1;
                $away -= 2;
            }
        }
    }
    @teams = reverse @teams if 'A' eq shift @game_results;

    return sprintf "Team %d defeated Team %d", @teams;
}

unless (caller) {
    require Run::WeeklyChallenge;
    require Cpanel::JSON::XS;
    Run::WeeklyChallenge::run_weekly_challenge(
        sub ($inputs) { Cpanel::JSON::XS->new->ascii->allow_nonref->encode(who_wins($inputs)) },
        'HAHAHH',
        '{"type":"string","pattern":"^[HA]+$"}',
    );
}
