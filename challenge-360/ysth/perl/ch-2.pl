use 5.036;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-360/#TASK2

sub word_sorter($sentence) {
    join ' ', sort { fc($a) cmp fc($b) } split ' ', $sentence;
}

unless (caller) {
    require Run::WeeklyChallenge;
    Run::WeeklyChallenge::run_weekly_challenge_v2(
        \&word_sorter,
        '"The quick brown fox"',
        '{"type":"string"}',
    );
}
