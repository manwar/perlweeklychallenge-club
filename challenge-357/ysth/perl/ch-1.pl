use 5.036;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-357/#TASK1

sub kaprekar_constant($int) {
    my %seen = ($int => 1);
    my $iterations = 0;
    while ($int != 6174) {
        ++$iterations;
        $int = join('', sort { $b cmp $a } split //, sprintf "%04d", $int) - join('', sort split //, sprintf "%04d", $int);
        return -1 if $seen{$int}++;
    }
    return $iterations;
}

unless (caller) {
    require Run::WeeklyChallenge;
    require Cpanel::JSON::XS;
    Run::WeeklyChallenge::run_weekly_challenge(
        sub ($inputs) { Cpanel::JSON::XS->new->ascii->allow_nonref->encode(kaprekar_constant($inputs)) },
        '3524',
        '{"type": "integer", "minimum": 0, "maximum": 9999}',
    );
}
