# Test: perl6 ch-2.p6
use v6.d;

sub MAIN(Bool :$optimal = False) {
    # Some initialization variables
    my @coins = (100, 50, 1, 10, 5, 20, 200, 2);
    my $players = 2;
    my $player_turn = 0;
    my @totals = map { 0 }, 1 .. $players;

    # Play the game
    while (@coins.elems > 0) {
    	if ( ($optimal && $player_turn == 0) ||
    	      @coins[0] > @coins[*-1] ) {
    		@totals[$player_turn] += @coins.shift;
    	} else {
    		@totals[$player_turn] += @coins.pop;
    	}

    	# Next turn
    	$player_turn = ($player_turn + 1) % $players;
    }

    for (1..$players) -> $i {
    	say "Player $i total: " ~ @totals[$i - 1] ~ 'p';
    }
}
