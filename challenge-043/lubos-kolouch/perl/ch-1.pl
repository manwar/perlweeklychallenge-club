use strict;
use warnings;
use Algorithm::Combinatorics qw(permutations);

# Initialize the ring numbers and available numbers
my %rings = (
    Blue   => 8,
    Black  => undef,
    Red    => 9,
    Yellow => 7,
    Green  => 5,
);
my @available = ( 1, 2, 3, 4, 6 );

# Generate all possible permutations of the available numbers
my $iter = permutations( \@available );

# Try each permutation for a valid solution
my @solutions;
while ( my $p = $iter->next ) {
    my ( $b, $k, $r, $y, $g ) = @$p;

    # Skip if any number is repeated
    next if ( $b == $k || $b == $r || $b == $y || $b == $g );
    next if ( $k == $r || $k == $y || $k == $g );
    next if ( $r == $y || $r == $g );
    next if ( $y == $g );

    # Check if the sum of numbers in each ring is 11
    if ( $b + $k + $r == 11 && $r + $y + $g == 11 ) {

        # Save the solution
        $rings{Blue}   = $b;
        $rings{Black}  = $k;
        $rings{Red}    = $r;
        $rings{Yellow} = $y;
        $rings{Green}  = $g;
        push @solutions, {%rings};
    }
}

# Print the solutions
if (@solutions) {
    print "Found ", scalar @solutions, " solutions:\n";
    for my $i ( 0 .. $#solutions ) {
        print "Solution ",  $i + 1,                 ":\n";
        print "  Blue:   ", $solutions[$i]{Blue},   "\n";
        print "  Black:  ", $solutions[$i]{Black},  "\n";
        print "  Red:    ", $solutions[$i]{Red},    "\n";
        print "  Yellow: ", $solutions[$i]{Yellow}, "\n";
        print "  Green:  ", $solutions[$i]{Green},  "\n";
    }
}
else {
    print "No solutions found.\n";
}
