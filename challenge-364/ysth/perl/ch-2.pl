use 5.036;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-364/#TASK2

sub goal_parser($string) {
    state %substitute = ('()'=>'o', '(al)'=>'al');
    state $substitute = qr/@{[join '|', map quotemeta, sort { length($b) <=> length($a) || $a cmp $b } keys %substitute]}/;

    my $result = $string =~ s/$substitute/$substitute{$&}/gr;
    return $result;
}

unless (caller) {
    require Run::WeeklyChallenge;
    Run::WeeklyChallenge::run_weekly_challenge_v2(
        \&goal_parser,
        '"G()(al)"',
        '{"type":"string"}',
    );
}
