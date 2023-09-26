use strict;
use warnings;

sub find_loops {
    my @arr = @_;
    my %visited;
    my $loop_count = 0;

    for my $i ( 0 .. $#arr ) {

        # Skip if this index has been visited
        next if exists $visited{$i};

        # Initialize a new loop
        $loop_count++;
        my $current_index = $i;

        # Find members of this loop
        while ( !exists $visited{$current_index} ) {
            $visited{$current_index} = 1;
            $current_index = $arr[$current_index];
        }
    }

    return $loop_count;
}

# Test cases
my @test_cases = (
    [
        [
            4, 6, 3, 8, 15, 0, 13, 18, 7, 16, 14, 19, 17, 5, 11, 1, 12, 2, 9,
            10
        ],
        3
    ],
    [
        [
            0, 1, 13, 7, 6, 8, 10, 11, 2, 14, 16, 4, 12, 9, 17, 5, 3, 18, 15,
            19
        ],
        6
    ],
    [
        [
            9, 8, 3, 11, 5, 7, 13, 19, 12, 4, 14, 10, 18, 2, 16, 1, 0, 15, 6,
            17
        ],
        1
    ]
);

for my $i ( 0 .. $#test_cases ) {
    my ( $arr, $expected ) = @{ $test_cases[$i] };
    my $result = find_loops(@$arr);
    print "Test case ", $i + 1, ": ",
      $result == $expected ? "Passed" : "Failed",
      " (Got: $result, Expected: $expected)\n";
}
