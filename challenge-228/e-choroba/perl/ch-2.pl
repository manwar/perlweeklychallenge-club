#! /usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub empty_array(@int) {
    my $steps = 0;
    my @sorted = sort { $a <=> $b } @int;
    while (@int) {
        if ($sorted[0] == $int[0]) {
            shift @sorted;
            shift @int;
        } else {
            push @int, shift @int;
        }
        ++$steps;
    }
    return $steps
}

use List::Util qw{ min };
sub empty_array_min(@int) {
    my $steps = 0;
    while (@int) {
        if (min(@int) == $int[0]) {
            shift @int;
        } else {
            push @int, shift @int;
        }
        ++$steps;
    }
    return $steps
}

use Test::More tests => 2 * 2 + 1;

is empty_array(3, 4, 2), 5, 'Example 1';
is empty_array(1, 2, 3), 3, 'Example 2';
is empty_array_min(3, 4, 2), 5, 'Example 1 min';
is empty_array_min(1, 2, 3), 3, 'Example 2 min';

use Benchmark qw{ cmpthese };
my %input;
@input{ map int rand 50, 1 .. 50 } = ();
my @input = keys %input;

is empty_array(@input), empty_array_min(@input), 'same';
cmpthese(-3, {
    min  => sub { empty_array_min(@input) },
    sort => sub { empty_array(@input) },
});

__END__
       Rate  min sort
min  3297/s   -- -39%
sort 5425/s  65%   --
