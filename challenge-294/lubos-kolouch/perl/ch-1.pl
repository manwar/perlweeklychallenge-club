#!/usr/bin/perl
use strict;
use warnings;

sub longest_consecutive_sequence {
    my @ints       = @_;
    my %nums       = map { $_ => 1 } @ints;    # Step 1: Create a set
    my $max_length = 0;

    foreach my $num (@ints) {                  # Step 2: Iterate over each number
                                               # Check if it's the start of a sequence
        unless ( exists $nums{ $num - 1 } ) {
            my $current_num    = $num;
            my $current_length = 1;

            # Step 3: Expand the sequence
            while ( exists $nums{ $current_num + 1 } ) {
                $current_num++;
                $current_length++;
            }

            # Step 4: Update the maximum length
            if ( $current_length > $max_length ) {
                $max_length = $current_length;
            }
        }
    }

    # Step 5: Return the result
    return $max_length > 1 ? $max_length : -1;
}

# Test cases
my @test_cases = (
    { ints => [ 10, 4, 20, 1, 3, 2 ],           expected =>  4 },
    { ints => [ 0, 6, 1, 8, 5, 2, 4, 3, 0, 7 ], expected =>  9 },
    { ints => [ 10, 30, 20 ],                   expected => -1 },
    { ints => [ 1, 9, 3, 10, 4, 20, 2 ],        expected =>  4 },
    { ints => [ 5, 6, 1, 2, 3, 4 ],             expected =>  6 },
    { ints => [ 100, 4, 200, 1, 3, 2 ],         expected =>  4 },
);

foreach my $test (@test_cases) {
    my $result = longest_consecutive_sequence( @{ $test->{ints} } );
    print "Input: \@ints = (" . join( ', ', @{ $test->{ints} } ) . ")\n";
    print "Output: $result\n";
    print "Expected: $test->{expected}\n";
    print "-" x 40 . "\n";
}
