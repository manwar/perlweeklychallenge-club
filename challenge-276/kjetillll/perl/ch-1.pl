use strict; use warnings; use Test::More tests=>3;

sub complete_day_pair_count {
    my $pairs = 0;
    "@_" =~ /
             \b(\d+)\b .+ \b(\d+)\b
             (??{ $pairs += ($1 + $2) % 24 == 0; '^' })
	    /x;
    $pairs
}

is complete_day_pair_count( @{ $$_{input} } ), $$_{output}
    for { input => [12, 12, 30, 24, 24], output => 2 },
        { input => [72, 48, 24, 5     ], output => 3 },
        { input => [12, 18, 24        ], output => 0 };
