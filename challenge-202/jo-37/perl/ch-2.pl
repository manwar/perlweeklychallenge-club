#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental 'postderef';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N1 N2...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N1 N2...
    List of altitudes

EOS


### Input and Output

say join ' ', widest_valley(@ARGV);


### Implementation

# Find the leftmost widest valley in a single pass through the list.
# This can be achieved by tracking every valley, identified by its
# starting index, length (in data points, not steps!) and current
# direction.  A valley at the end of its uphill slope is considered
# "closed" and is marked with a zero direction.
#
sub widest_valley {
    # Start with one valley consisting of a single point downhill slope.
    # This enables a starting uphill half-valley.
    my  @valleys = ({start => 0, length => 1, dir => -1});
    my $widest = $valleys[0];
    for my $i (0 .. $#_ - 1) {
        my $dir = $_[$i + 1] <=> $_[$i];
        # Mark the potential beginning of a new valley on a
        # non-ascending step.
        my $new = $dir <= 0;
        for my $valley (@valleys) {
            # Skip "closed" valleys.
            next unless $valley->{dir};

            # Close the valley if it goes uphill and the next step goes
            # downhill.
            #  _
            # / \
            #
            # In all other cases the next step extends the valley and
            # may lead to a new maximum.
            #
            # \_  \__ \_/  __  _/
            #   \         /   /   
            if ($valley->{dir} > 0 && $dir < 0) {
                $valley->{dir} = 0;
            } else {
                $widest = $valley
                    if ++$valley->{length} > $widest->{length};
            }
            # Invert the valley's direction to uphill if the next step
            # goes uphill.
            #
            # \_/
            $valley->{dir} = 1 if $valley->{dir} < 0 && $dir > 0;

            # A (non-ascending) step that extends the downhill slope of
            # a valley is not the beginning of a new valley.
            # _   _
            #  \_  \
            #       \
            $new = 0 if $valley->{dir} < 0;
        }
        # Open a new valley if a non-ascending step is not part of a
        # known valley's downhill slope.
        #   _    
        # _/  _/\
        #
        # If the new valley starts with an indifferent step, it might
        # turn out to be part of an uphill slope later, though. It would
        # not violate the definition of a valley but cannot be maximal.
        # Such spurious valleys do not hurt in this task.
        #
        #   _/
        # _/
        push @valleys, {start => $i, length => 2, dir => -1} if $new;
    }

    # Extract the leftmost widest valley.
    splice @_, $widest->{start}, $widest->{length};
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [widest_valley(1, 5, 5, 2, 8)],
            [5, 5, 2, 8], 'example 1';
        is [widest_valley(2, 6, 8, 5)],
            [2, 6, 8], 'example 2';
        is [widest_valley(9, 8, 13, 13, 2, 2, 15, 17)],
            [13, 13, 2, 2, 15, 17], 'example 3';
        is [widest_valley(2, 1, 2, 1, 3)],
            [2, 1, 2], 'example 4';
        is [widest_valley(1, 3, 3, 2, 1, 2, 3, 3, 2)],
            [3, 3, 2, 1, 2, 3, 3], 'example 5';
    }

    SKIP: {
        skip "tests" unless $tests;

        is [widest_valley(1, 2, 3, 4, 3, 4)], [1, 2, 3, 4], 'half at start';
        is [widest_valley(4, 3, 4, 3, 2, 1)], [4, 3, 2, 1], 'haft at end';
        is [widest_valley(2, 1, 2, 2, 1, 2, 2, 1, 2)],
            [2, 2, 1, 2, 2], 'embedded';
        is [widest_valley(2, 1, 2, 2, 3, 3, 4, 4, 1)],
            [2, 1, 2, 2, 3, 3, 4, 4], 'spurious valleys';
	}

    done_testing;
    exit;
}
