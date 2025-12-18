use 5.036;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-352/#TASK1

sub match_string(@words) {
    my @result;
    my %found;
    for my $i (0..$#words) {
        my $word = $words[$i];
        next if exists $found{$word};
        for my $j (0..$#words) {
            if ($i != $j && index($words[$j], $word) >= 0) {
                $found{$word} = ();
                push @result, $word;
                last;
            }
        }
    }

    return @result;
}

unless (caller) {
    require Run::WeeklyChallenge;
    Run::WeeklyChallenge::run_weekly_challenge(
        sub ($inputs) { '(' . join(', ', map "\"$_\"", match_string(@$inputs)) . ')' },
        '["cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"]',
        '{"type":"array", "items": {"type": "string"}}',
    );
}
