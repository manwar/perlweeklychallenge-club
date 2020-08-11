#!/usr/bin/perl
# Test: ./ch-1.pl 2 3
use strict;
use warnings;
use feature qw /say/;

my $b = $ARGV[0];
my $n = $ARGV[1];

# Calculate $n if not supplied
$n = int(log($b) / log(2)) + 1
    unless($n);

# Lets keep it to 1 to 32 bits and
# throw out bits outside of our range
$n = 32 if ($n > 32);
$n = 1  if ($n < 1);
my $mask = (2 ** $n - 1);
$b = $b & $mask;

# Print the original number
say "ORIGINAL: " . sprintf("%0${n}B", $b) . "\n";

# Store the solution;
my %solutions;
my $longest_soluton = 0;

# flip algorithm
for my $l (0 .. $n -1) {
    for my $r ($l .. $n - 1) {
        # We create two bit masks.
        # The first mask is what we use to flip the bits
        # and the second mask is what we use to keep the
        # original builts then add up the flipped bits
        # with the kept bits

        # Flip Mask
        my $flip_mask = 0;
        for my $i ($l .. $r) {
        	$flip_mask += (2 ** ($n - $i - 1) );
        }

        # Calculate the keep mask
        my $keep_mask = (~ $flip_mask) & $mask;

        # Flip the relevant bits and calculate kept bits
        my $flipped_bits =  ~ ($b & $flip_mask) & $flip_mask;
        my $kept_bits    = $b & $keep_mask;

        # Add the bits outside the flipped bit
        my $flipped_number = $flipped_bits + $kept_bits;

        # Now store the number of ones
        my $length = calculate_true_bits($flipped_number);

        # Store the solutions
        $solutions{$length} = []
        	unless ($solutions{$length});

        push @{$solutions{$length}}, {
        	L      => $l,
        	R      => $r,
        	number => $flipped_number
        };

        # Length of the longest solution
        $longest_soluton = $length
        	if ($longest_soluton < $length);
    }
}

# Print the solutions
say "SOLUTIONS length($longest_soluton):";
for my $solution (@{$solutions{$longest_soluton}}) {
    say 'L: ' . $solution->{L} .
        ' R: ' . $solution->{R} .
        ' number: ' . sprintf("%0${n}B", $solution->{number});
}

# Calculate the number of true bits
sub calculate_true_bits {
    my $number = shift;
    my $count = 0;

    do {
        $count++ if ($number & 1);
    } while ($number = $number >> 1);

    return $count;
}
