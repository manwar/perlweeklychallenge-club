use strict;
use warnings;
use feature qw/say/;

my %cache;

sub get_houses_max {
    my @houses = @_;

    return $cache{@houses} if $cache{@houses};
        
    my $max_value = 0;
    my $house_index = 0;
    for my $house (@houses[2..@houses-1]) {
        my $next_houses_values = get_houses_max(@houses[2+$house_index..@houses-1]);
        $max_value = $next_houses_values if $next_houses_values > $max_value;
        $house_index++;
    }

    $cache{@houses} = $houses[0] + $max_value;
    return $houses[0] + $max_value;

}

use Test::More;

is(get_houses_max((2,4,5)), 7);
undef %cache;
is(get_houses_max((4, 2, 3, 6, 5, 3)), 13);

done_testing;
