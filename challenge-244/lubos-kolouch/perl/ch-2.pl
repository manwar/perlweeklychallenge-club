use List::Util qw(min max);
use Math::Combinatorics;

sub group_hero_power {
    my @nums        = @_;
    my $total_power = 0;

    for my $i ( 1 .. scalar @nums ) {
        my $combinat = Math::Combinatorics->new( count => $i, data => [@nums] );
        while ( my @combo = $combinat->next_combination ) {
            my $power = max(@combo)**2 * min(@combo);
            $total_power += $power;
        }
    }
    return $total_power;
}

# Tests
use Test::More tests => 1;
is( group_hero_power( 2, 1, 4 ), 141, 'Test Case 1' );
