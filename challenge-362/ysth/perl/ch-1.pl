use 5.040;
use List::Util 1.29 'pairmap';

# https://theweeklychallenge.org/blog/perl-weekly-challenge-362/#TASK1

sub echo_chamber($string) {
    join '', pairmap { $b x ($a+1) } indexed [split //, $string]->@*
}

unless (caller) {
    require Run::WeeklyChallenge;
    Run::WeeklyChallenge::run_weekly_challenge_v2(
        \&echo_chamber,
        '"abca"',
        '{"type":"string", "pattern":"^\\\\p{Ll}+$"}'
    );
}

# https://perlmonks.org/?node_id=322751
