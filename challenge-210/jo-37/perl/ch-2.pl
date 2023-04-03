#!/usr/bin/perl -s

use v5.22;
use Test2::V0;
use List::MoreUtils 'zip6';
use experimental 'refaliasing';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [--] [NUM...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

NUM...
    list of numbers

EOS


### Input and Output

say "(@{number_collision(@ARGV)})";


### Implementation

# Maybe there is a way to solve this puzzle just by looking at the
# numbers.  I don't see one.  So we're going play the game to find the
# result.

sub number_collision {
    # Distribute the numbers onto two arrays depending on the sign,
    # which defines the moving direction. Inserting 'undef' to keep
    # every number's position.
    my (@right, @left);
    for (@_) {
        push @left, $_ < 0 ? $_ : undef;
        push @right, $_ < 0 ? undef : $_;
    }
    # Our 'frame of reference' is given by the numbers moving left, i.e.
    # negative values never change their position, whereas positive
    # number are shifted to the right.
    # Initialise two index positions of
    # - the leftmost positive number
    # - the rightmost negative number
    my ($r, $l) = (0, 'inf');
    # As long as the first index is smaller than the second, there are
    # collisions ahead.
    while ($r < $l) {
        ($r, $l) = ('inf', 0);
        # Move right.
        unshift @right, undef;
        # Process all number pairs.
        for my $i (0 .. $#right) {
            # Get a shorthand for the pair.
            \my ($ri, $li) = \($right[$i], $left[$i]);
            # Get the pair's values with default.
            my ($ri_d, $li_d) = ($ri // -1, $li // 1);
            # Find the result of a collision.
            ($ri, $li) = ( $ri_d <= -$li_d ? undef : $ri,
                          -$li_d <=  $ri_d ? undef : $li);
            # Adjust indices.
            $r = $i if defined $ri && $i < $r;
            $l = $i if defined $li;
        }
    }
    [map $_->[0] // $_->[1] // (), zip6 @right, @left];

}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is number_collision(2, 3, -1), [2, 3], 'example 1';
        is number_collision(2, 3, -4), [-4], 'example 2';
        is number_collision(1, -1), [], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is number_collision(0), [0], 'surviving zero';
        is number_collision(1, -2, 3, 1, -3, 4, 2, -4, 5, 3, 1, -6),
        [-2, -6], 'the big pwc number massacre';
	}

    done_testing;
    exit;
}
