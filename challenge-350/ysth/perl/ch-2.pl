use 5.040;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-350/#TASK2

# shuffle_pairs
# from/to: range of integers
# count: number of shuffle pairs
# return number of integers in the range that belong to at least the specified number of pairs
sub shuffle_pairs($from, $to, $count) {
    my $qualifying_integers = 0;
    I:
    for my $i ($from..$to) {
        my $pairs = 0;
        my $i_sorted = join '', sort split //, $i;

        # maximum higher number can't have more digits
        for my $witness (2..int((10**length($i) - 1) / $i)) {
            if ($i_sorted eq join '', sort split //, $i * $witness) {
                if (++$pairs == $count) {
                    ++$qualifying_integers;
                    next I;
                }
            }
        }
        # maximum witness can't be more than i's first digit
        for my $witness (2..substr $i, 0, 1) {
            if (!( $i % $witness ) && $i_sorted eq join '', sort split //, $i / $witness) {
                if (++$pairs == $count) {
                    ++$qualifying_integers;
                    next I;
                }
            }
        }
    }
    return $qualifying_integers;
}

unless (caller) {
    require Run::WeeklyChallenge;
    Run::WeeklyChallenge::run_weekly_challenge(
        sub ($inputs) { shuffle_pairs(@$inputs{qw/from to count/}) },
        '{"from":1,"to":1000,"count":1}',
        '{
            "type": "object",
            "properties": {
                "from": {"type": "integer", "minimum": 0},
                "to": {"type": "integer", "minimum": 0},
                "count": {"type": "integer"}
            },
            "required": ["from", "to", "count"],
            "additionalProperties": false
        }',
    );
}
