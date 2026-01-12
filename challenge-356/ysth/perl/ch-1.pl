use 5.036;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-356/#TASK1

sub kolakoski_sequence($length) {
    my @sequence = (1,2,2);
    for (my $i = 2; $i < $length; ++$i) {
        push @sequence, (3-$sequence[-1]) x $sequence[$i];
    }
    splice @sequence, $length;

    return scalar grep $_ == 1, @sequence;
}

unless (caller) {
    require Run::WeeklyChallenge;
    require Cpanel::JSON::XS;
    Run::WeeklyChallenge::run_weekly_challenge(
        sub ($inputs) { Cpanel::JSON::XS->new->ascii->allow_nonref->encode(kolakoski_sequence($inputs)) },
        '4',
        '{"type": "integer", "minimum": 3}',
    );
}
