#!/usr/bin/perl
use strict;
use warnings;

sub min_jumps {
    my @ints = @_;
    my $n    = scalar @ints;

    # Edge cases
    return 0  if $n <= 1;
    return -1 if $ints[0] == 0;

    my $jumps       = 0;
    my $current_end = 0;
    my $farthest    = 0;

    for my $i ( 0 .. $n - 2 ) {
        $farthest = ( $i + $ints[$i] > $farthest ) ? $i + $ints[$i] : $farthest;

        # If we have reached the end of what the last jump could reach
        if ( $i == $current_end ) {
            $jumps++;
            $current_end = $farthest;

            # If current_end is beyond or at the last index, we can reach the end
            return $jumps if $current_end >= $n - 1;
        }

        # If the farthest we can reach is less than or equal to the current index
        if ( $farthest <= $i ) {
            return -1;
        }
    }

    return -1;
}

# Test cases
my @test_cases = (
    { ints => [ 2, 3, 1, 1, 4 ], expected =>  2 },
    { ints => [ 2, 3, 0, 4 ],    expected =>  2 },
    { ints => [ 2, 0, 0, 4 ],    expected => -1 },
    { ints => [ 1, 1, 1, 1 ],    expected =>  3 },
    { ints => [0],               expected =>  0 },
    { ints => [ 1, 0, 1, 0 ],    expected => -1 },
    { ints => [ 2, 1 ],          expected =>  1 },
    { ints => [ 1, 2, 3 ],       expected =>  2 },
);

foreach my $test (@test_cases) {
    my $result = min_jumps( @{ $test->{ints} } );
    print "Input: \@ints = (" . join( ', ', @{ $test->{ints} } ) . ")\n";
    print "Output: $result\n";
    print "Expected: $test->{expected}\n";
    print "-" x 40 . "\n";
}
