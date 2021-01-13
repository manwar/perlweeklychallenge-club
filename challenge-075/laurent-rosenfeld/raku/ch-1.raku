use v6;

my $target_sum = shift @*ARGS;
my @coins = @*ARGS.sort.squish;
my @result;
find-sum(0, []);
.say for @result;

sub find-sum (Int $start, @allocated-so-far) {
    return if $start > $target_sum;
    if $start == $target_sum {
        push @result, join " ", @allocated-so-far;
        return;
    }
    my $last-coin = 0;
    $last-coin = @allocated-so-far[*-1] if defined @allocated-so-far[*-1];
    for @coins.grep({$_ >= $last-coin}) -> $coin {
        find-sum($start + $coin, (| @allocated-so-far, $coin));
    }
}
