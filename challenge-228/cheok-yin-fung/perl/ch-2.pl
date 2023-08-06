# The Weekly Challenge 228
# Task 2 Empty Array
use v5.30.0;
use warnings;
use List::Util qw/min/;

sub ea {
    my @int = @_;
    my $c = 0;
    while (@int != 0) {
        if ($int[0] == min @int) {
            shift @int;
        }
        else {
            my $temp = $int[0];
            shift @int;
            push @int, $temp;
        }
        $c++;
    }
    return $c;
}

use Test::More tests=>2;
ok ea(3,4,2) == 5;
ok ea(1,2,3) == 3;
