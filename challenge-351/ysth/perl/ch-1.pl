use 5.040;
use Math::BigRat;
use Math::BigInt;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-351/#TASK1

# average of integers excluding minimum and maximum values
sub special_average($integers) {
    my $minimum = Math::BigInt->binf();
    my $maximum = Math::BigInt->binf('-');
    ($minimum > $_ and $minimum = $_),($maximum < $_ and $maximum = $_) for @$integers;
    my %exclude = (
        $minimum => 1,
        $maximum => 1,
    );
    my $sum = 0;
    my $count = 0;
    ! $exclude{$_} and ($sum += $_, ++$count) for @$integers;

    my $special_average = Math::BigRat->new($sum, $count || 1);

    return $special_average;
}

unless (caller) {
    require Run::WeeklyChallenge;
    Run::WeeklyChallenge::run_weekly_challenge(\&special_average, '[8000, 5000, 6000, 2000, 3000, 7000]', '{"type":"array", "items": {"type": "integer"}}');
}
