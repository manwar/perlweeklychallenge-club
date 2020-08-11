#!/usr/bin/env perl6

# ch-2.p6 - Lucky Winner
#
# Ryan Thompson <rjt@cpan.org>

#| A more literal reading of the problem, with a simple greedy CPU
sub MAIN( Bool :$me-first ) {
    my @coins = @*ARGV ?? @*ARGV !! <100 50 1 10 5 20 200 2>;

    my $my-score = 0;
    my $cpu-score= 0;
    my $my-turn  = $me-first;

    while (@coins) {
        say @coins;
        if ($my-turn) {
            my $lr;
            repeat { $lr = prompt "Move [lr]? " } until 'lr'.index($lr) ≥ 0;
            $my-score += $lr eq 'l' ?? @coins.shift !! @coins.pop;
        } else {
            $cpu-score += @coins[0] > @coins[*-1] ?? @coins.shift !! @coins.pop;
        }
        $my-turn = !$my-turn;
    }

    say $my-score > $cpu-score ?? "You win" !! "CPU wins";
    say "Your score: $my-score. CPU score: $cpu-score";
}
