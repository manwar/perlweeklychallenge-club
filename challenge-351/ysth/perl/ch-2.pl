use 5.040;
use Math::BigRat;
use Math::BigInt;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-351/#TASK2

sub arithmetic_progression($numbers) {
    return true if @$numbers <= 2;

    my @sorted  = sort { $a <=> $b } @$numbers;

    my $minimum = Math::BigFloat->binf();
    my $maximum = Math::BigFloat->binf('-');
    my %uniq;
    ($minimum > $_ and $minimum = $_),($maximum < $_ and $maximum = $_),++$uniq{$_} for @$numbers;

    # not all unique, no need to check anything else
    return false if @$numbers != keys %uniq;

    my $step = ($maximum - $minimum) / (@$numbers - 1);
    # some aren't in progression?
    return 0 == grep +(($_-$minimum)/$step) =~ /\./, @$numbers;
}

unless (caller) {
    require Run::WeeklyChallenge;
    Run::WeeklyChallenge::run_weekly_challenge(sub ($inputs) { arithmetic_progression($inputs) ? 'true' : 'false' }, '[1, 3, 5, 7, 9]', '{"type":"array", "items": {"type": "number"}}');
}
