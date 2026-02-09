use 5.036;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-359/#TASK1

sub digital_root($int) {
    my $persistence = 0;
    ++$persistence, $int = eval $int while $int =~ s/\B/+/g;
    return $persistence, $int;
}

unless (caller) {
    require Run::WeeklyChallenge;
    require Cpanel::JSON::XS;
    Run::WeeklyChallenge::run_weekly_challenge(
        sub ($inputs) { Cpanel::JSON::XS->new->ascii->allow_nonref->encode([digital_root($inputs)]) },
        '38',
        '{"type": "integer", "minimum": 0}',
    );
}
