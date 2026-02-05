use 5.036;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-359/#TASK2

sub string_reduction($word) {
    1 while $word =~ s/(.)\1//g;
    return $word;
}

unless (caller) {
    require Run::WeeklyChallenge;
    require Cpanel::JSON::XS;
    Run::WeeklyChallenge::run_weekly_challenge(
        sub ($inputs) { Cpanel::JSON::XS->new->ascii->allow_nonref->encode(string_reduction($inputs)) },
        '"aabbccdd"',
        '{"type":"string"}',
    );
}
