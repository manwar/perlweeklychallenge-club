use strict;
use warnings;

# Function to check if two arrays contain the same elements
sub arrays_are_equal {
    my ($a_ref, $b_ref) = @_;
    my @a = sort { $a <=> $b } @$a_ref;
    my @b = sort { $a <=> $b } @$b_ref;

    return 0 if @a != @b;
    for my $i (0 .. $#a) {
        return 0 if $a[$i] != $b[$i];
    }
    return 1;
}

# Function to find the magic number
sub find_magic_number {
    my ($x_ref, $y_ref) = @_;
    my @x = @$x_ref;
    my @y = @$y_ref;

    # Print input arrays for debugging
    print "Array x: (", join(", ", @x), ")\n";
    print "Array y: (", join(", ", @y), ")\n";

    # Check if the arrays are empty or have different sizes
    if (!@x || !@y) {
        die "One of the input arrays is empty";
    }
    if (@x != @y) {
        die "Input arrays have different sizes";
    }

    # Calculate possible magic number candidates
    my %candidates;
    for my $i (0 .. $#x) {
        for my $j (0 .. $#y) {
            my $candidate = $y[$j] - $x[$i];
            $candidates{$candidate}++;
        }
    }

    # Test each candidate
    for my $candidate (keys %candidates) {
        my @transformed_x = map { $_ + $candidate } @x;
        if (arrays_are_equal(\@transformed_x, \@y)) {
            return $candidate;
        }
    }

    die "No magic number found";
}

# Example 1
my @x1 = (3, 7, 5);
my @y1 = (9, 5, 7);
print "Example 1: Magic number is ", find_magic_number(\@x1, \@y1), "\n";

# Example 2
my @x2 = (1, 2, 1);
my @y2 = (5, 4, 4);
print "Example 2: Magic number is ", find_magic_number(\@x2, \@y2), "\n";

# Example 3
my @x3 = (2);
my @y3 = (5);
print "Example 3: Magic number is ", find_magic_number(\@x3, \@y3), "\n";
