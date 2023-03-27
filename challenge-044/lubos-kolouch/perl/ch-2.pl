use strict;
use warnings;

my $goal    = 200;    # Target amount
my $current = 1;      # Current amount
my $moves   = 0;      # Number of moves

while ( $current < $goal ) {

    # Check if doubling the current amount gets us closer to the goal
    if ( $current * 2 <= $goal - $current - 1 ) {
        $current *= 2;
    }
    else {
        $current += 1;
    }
    $moves += 1;
}

print "To reach $goal, you need $moves moves.\n";
