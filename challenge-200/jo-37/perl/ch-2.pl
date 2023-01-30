#!/usr/bin/perl -s

use v5.16;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;
use experimental qw(signatures postderef);

our ($tests, $examples, $p, $q);
$p //= 7;
$q //= 5;
die "p too small" if $p < 5;
die "q too small" if $q < 5;


run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-p=P] [-q=Q] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-p=P
-q=Q
    dimensions of the generated 7-segment digits.
    Defaults: P=7, Q=5

N
    number to be presented using 7-segment digits.

EOS


### Input and Output

say_seven_segments($p, $q, shift);


### Implementation

# Fun solution to fun task.

BEGIN {
    # Define segments as slices within a PxQ piddle together with their
    # character representation.  In default dimensions 7x5:
    # ╔═══════╗
    # ║  ---  ║
    # ║ |   | ║ upper
    #_║  ---  ║_
    # ║ |   | ║
    # ║  ---  ║ lower
    # ╚═══════╝
    # Each segment is described by four elements:
    # - the character to be printed
    # - the part index (upper = 0, lower = 1)
    # - the column index range
    # - the row index range
    # Notes:
    # - Segment 'g' is located at the last row of the upper part.
    # - The lower part's last row is virtual when the number of rows is
    #   odd and thus not usable.
    # - All slices are defined in absolute offsets from some borders and
    #   thus independent from the actual dimensions.
    my @segments = (['-', [0], [2, -3], [0]], ['|', [0], [-2], [1, -2]],
        ['|', [1], [-2], [0, -3]], ['-', [1], [2, -3], [-2]],
        ['|', [1], [1], [0, -3]], ['|', [0], [1], [1, -2]],
        ['-', [0], [2, -3], [-1]]);
    # The following segment definition - when used in size 9x7 -
    # reproduces the given example.  But I prefer the above design.
    # my @segments = (['-', [0], [1, -2], [0]], ['|', [0], [-2], [1, -2]],
    #    ['|', [1], [-2], [0, -3]], ['-', [1], [1, -2], [-2]],
    #    ['|', [1], [1], [0, -3]], ['|', [0], [1], [1, -2]],
    #    ['-', [0], [1, -2], [-1]]);

    sub segments ($p, $q) {
        # Start index of the lower part:
        my $l = ($q + 1) / 2;

        # Stack the individual segments' pixel planes.
         cat(
            map {
                # Get the pixels for a single segment and set them to their
                # character representation.
                my $s = zeroes byte, $p, $q;
                # Split the pixels into an upper and lower part.
                my $ul = $s->range([[0, 0], [0, $l]], [$p, $l], 't');
                # Draw a segment.
                $ul($_->@[1..3]) .= ord $_->[0];
                $s;
            } @segments
        )->reorder(2, 0, 1);
    }
}

# Convert the truth table to an array of index piddles representing
# the corresponding segments.
sub decto7 {
    map indx(map ord, split //) - ord('a'),
        qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;
}

sub say_seven_segments ($p, $q, $n) {
    my $segments = segments($p, $q);
    my @decto7 = decto7;

    # Create a (P*L)xQ piddle holding the pixels of the given number
    # (with L as the length of N) by concatenating the individual
    # digits' pixels line-wise. 
    my $out = byte cat(
        # Select the segments as given by the truth table for every
        # single digit and combine them.
        map $segments($decto7[$_])->sumover, split //, $n
    )->clump(0, 2);

    # Print the pixels line-wise, mapping zero to blank and non-zero
    # to the corresponding character.
    say map $_ ? chr : ' ', $_->list for $out->dog;
}


### Examples and tests

sub run_tests {
    use autodie;

    SKIP: {
        skip "examples" unless $examples;

        say_seven_segments(9, 7, 200); # Sized like the example
    }

    SKIP: {
        skip "tests" unless $tests;

        open my $save, '>&', \*STDOUT;
        close STDOUT;
        open STDOUT, '>', \my $capture;

        say_seven_segments(7, 5, 8);

        close STDOUT;
        open STDOUT, '>&', $save;

        is $capture, <<EOS, 'check eight';
  ---  
 |   | 
  ---  
 |   | 
  ---  
EOS
	}

    done_testing;
    exit;
}
