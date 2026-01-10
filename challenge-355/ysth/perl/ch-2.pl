use 5.040;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-355/#TASK2

# true if integers in ints monotonically increase then decrease
sub mountain_array($ints) {
    return false if @$ints < 3 || $ints->[0] >= $ints->[1] || $ints->[-2] <= $ints->[-1];

    my $direction = 1;
    my $i = $#$ints;
    while (--$i > 1) {
        if ($direction != (my $new_direction = $ints->[$i] <=> $ints->[$i+1])) {
            if ($direction == 1 && $new_direction == -1) {
                $direction = -1;
            }
            else {
                return false;
            }
        }
    }
    return true;
}

unless (caller) {
    require Run::WeeklyChallenge;
    require Cpanel::JSON::XS;
    Run::WeeklyChallenge::run_weekly_challenge(
        sub ($inputs) { Cpanel::JSON::XS->new->ascii->allow_nonref->encode(mountain_array($inputs)) },
        '[1, 2, 3, 4, 5]',
        '{"type":"array", "items": {"type": "integer"}}',
    );
}
