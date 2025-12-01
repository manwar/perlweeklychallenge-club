use 5.040;
use List::Util 1.29;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-349/#TASK1

# find length of longest character repetition
sub power_of_string($string) {
    my $longest = List::Util::max( map length $_->[0], List::Util::pairs $string =~ /((.)\2*)/sg );

    return $longest;
}

unless (caller) {
    require Run::WeeklyChallenge;
    Run::WeeklyChallenge::run_weekly_challenge(\&power_of_string, '"textbook"', '{"type":"string","minLength":1}');
}
