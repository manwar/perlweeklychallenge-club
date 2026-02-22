use 5.042;
use experimental 'keyword_any';

# https://theweeklychallenge.org/blog/perl-weekly-challenge-361/#TASK2

sub find_celebrity($party) {
    use Exception::Class 'InvalidParty' => { 'description' => 'Party must be a square matrix' };
    my $people = @$party;
    InvalidParty->throw() if any { $people != @$_ } @$party;

    my $all = my $celebrity = 2**$people - 1;
    for my $person (0..$#$party) {
        my $knows = oct('b' . reverse join '',$party->[$person]->@*);
        $celebrity &= $knows ? $knows & ~(1<<$person) : (1<<$person)
    }
    return $celebrity ? length(sprintf '%b', $celebrity) - 1 : -1;
}

unless (caller) {
    require Run::WeeklyChallenge;
    Run::WeeklyChallenge::run_weekly_challenge_v2(
        \&find_celebrity,
        '[ [0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 1, 0] ]',
        '{"type":"array", "items": {"type":"array", "items": {"type":"integer","minimum":0,"maximum":1}}}',
    );
}
