use 5.036;
use List::Util 1.56 'mesh';

# https://theweeklychallenge.org/blog/perl-weekly-challenge-364/#TASK1

sub decrypt_string($string) {
    state %substitute = mesh [1..9, map "$_#", 10..26], ['a'..'z'];
    state $substitute = qr/@{[join '|', map quotemeta, sort { length($b) <=> length($a) || $a cmp $b } keys %substitute]}/;

    my $result = $string =~ s/$substitute/$substitute{$&}/gr;
    return $result;
}

unless (caller) {
    require Run::WeeklyChallenge;
    Run::WeeklyChallenge::run_weekly_challenge_v2(
        \&decrypt_string,
        '"10#11#12"',
        '{"type":"string"}',
    );
}
