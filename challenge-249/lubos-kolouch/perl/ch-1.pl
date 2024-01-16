use strict;
use warnings;
use Test::More;

sub equal_pairs {
    my @ints = @_;
    my %freq;
    my @order;

    # Count the frequency of each element and track the order
    foreach my $int (@ints) {
        if ( !exists $freq{$int} ) {
            push @order, $int;
        }
        $freq{$int}++;
    }

    # Check if all elements have even frequency
    foreach my $key ( keys %freq ) {
        return [] if $freq{$key} % 2;    # Returning an array reference
    }

    # Form pairs
    my @pairs;
    foreach my $key (@order) {
        push @pairs, ( [ $key, $key ] ) x ( $freq{$key} / 2 );
    }

    return \@pairs;
}

# Test cases
subtest 'Test Cases' => sub {
    is_deeply(
        equal_pairs( 3, 2, 3, 2, 2, 2 ),
        [ [ 3, 3 ], [ 2, 2 ], [ 2, 2 ] ],
        'Example 1'
    );
    is_deeply( equal_pairs( 1, 2, 3, 4 ), [], 'Example 2' ); # Revised test case
};

done_testing();
