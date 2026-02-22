use 5.036;
use List::Util 'first';

# https://theweeklychallenge.org/blog/perl-weekly-challenge-361/#TASK1

sub _fibonacci($through) {
    my @fibonacci = (2,1);
    while ((my $fibonacci = $fibonacci[0]+$fibonacci[1]) < $through) {
        unshift @fibonacci, $fibonacci;
    }
    return @fibonacci;
}

sub zeckendorf_representation($int) {
    [ map 0+$_, (first { eval == $int } glob join '', map "{+$_,}", _fibonacci($int)) =~ /\d+/ga ]
}

unless (caller) {
    require Run::WeeklyChallenge;
    Run::WeeklyChallenge::run_weekly_challenge_v2(
        \&zeckendorf_representation,
        '4',
        '{"type":"integer", "minimum":1, "maximum":100}',
    );
}
