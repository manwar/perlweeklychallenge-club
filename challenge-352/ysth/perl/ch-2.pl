use 5.036;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-352/#TASK2

sub binary_prefix($nums) {
    reverse map !!length, reverse(join '', @$nums) =~ /(?=((?:1(?:101*0)*(?:11|0)(?:01|001*0(?:101*0)*(?:11|0))*1|0)+\z|))./g
}

unless (caller) {
    require Run::WeeklyChallenge;
    Run::WeeklyChallenge::run_weekly_challenge(
        sub ($inputs) { '(' . join(', ', map(($_ ? 'true' : 'false'), binary_prefix($inputs))) . ')' },
        '[0,1,1,0,0,1,0,1,1,1]',
        '{"type":"array", "items": {"type": "integer", "minimum": 0, "maximum": 1}}',
    );
}
