#!/usr/bin/perl
# test: ./ch-2.pl
use strict;
use warnings;
use feature qw /say/;

my $min_steps = 15;
my $min_solution;

add_or_double(1, 0, '');
say 'Found smallest solution in ' . $min_steps . ' steps: ' . $min_solution;

sub add_or_double {
    my ($cash, $steps, $solution) = @_;
    $steps++;

    # Let's not deep recurse past 15
    if ($steps > 15) {
        return undef;
    }

    if ($cash == 200) {
        if ($min_steps > $steps) {
            $min_steps = $steps;
            $min_solution = $solution;
        }
    }

    if ($cash * 2 <= 200 ) {
        add_or_double($cash * 2, $steps, $solution . 'd' );
    }

    if ($cash + 1 <= 200) {
        add_or_double($cash + 1, $steps, $solution . 'a');
    }
}
