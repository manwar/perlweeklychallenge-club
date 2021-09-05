#!/usr/bin/perl

use strict;
use warnings;

################################################################################
# Begin main execution
################################################################################

my @matrices = (
    # This matrix actually has two equivalent
    # rectangles of zeros... my method tends
    # to be biased toward the vertically
    # oriented ones in such cases
    [
        [ 1, 0, 0, 0, 1, 0 ],
        [ 1, 1, 0, 0, 0, 1 ],
        [ 1, 0, 0, 0, 0, 0 ]
    ],
    [
        [ 0, 0, 1, 1 ],
        [ 0, 0, 0, 1 ],
        [ 0, 0, 1, 0 ]
    ],
    # Another test case
    [
        [ 1, 0, 0, 0, 1, 1, 1 ],
        [ 1, 1, 1, 1, 1, 0, 1 ],
        [ 1, 1, 0, 0, 1, 0, 1 ],
        [ 1, 1, 0, 0, 1, 0, 1 ],
        [ 1, 1, 1, 1, 1, 1, 1 ],
    ]
);
my $matrix;

foreach $matrix (@matrices){
    print("Input:\n");
    print_matrix($matrix, "    ");

    print("Output:\n");
    print_matrix(find_max_rectangle_zeros($matrix), "    ");

    print("\n");
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Find the largest rectangular area of zeros in a matrix (2D array) of
# numerical values
# Takes one argument:
# * A ref to the matrix
# Returns:
# * A ref to a matrix sliced from the larger matrix, which contains the largest
#   rectangular area of zeros found therein
# Adapted from the method seen here:
# https://www.youtube.com/watch?v=g8bSdXCG-lA
################################################################################
sub find_max_rectangle_zeros{
    my $matrix = shift();

    my $i;
    my $j;
    my @histogram;
    my $hist_data;
    my $max_hist_data = { area => 0 };

    @histogram = map({ 0 } (0 .. $#$matrix));
    $i = scalar(@{$matrix->[0]});
    while($i--){
        $j = scalar(@{$matrix});
        while($j--){
            if($matrix->[$j][$i]){
                # The value is 1; reset this cell in the
                # histogram
                $histogram[$j] = 0;
            } else{
                # The value is 0; increment this cell in
                # the histogram
                $histogram[$j]++;
            }
        }

        # Find the largest rectangle under the
        # current histogram and see if it's
        # bigger than any we've seen yet
        $hist_data = find_max_rectangle_under_histogram(\@histogram);
        if($hist_data->{area} > $max_hist_data->{area}){
            # Area is bigger- make a note of it, and
            # where we found it
            $max_hist_data = $hist_data;
            $max_hist_data->{matrix_index} = $i;
        }
    }

    return(
        # Make an anonymous array of refs to
        # all the slices
        [
            map(
                {
                    # Make an anonymous array out of a
                    # slice from this row of the matrix
                    $j = $_;
                    [
                        map(
                            { $matrix->[$j][$_] }
                            # Horizontal range
                            $max_hist_data->{matrix_index}
                            ..
                            $max_hist_data->{matrix_index}
                                + $max_hist_data->{height} - 1
                        )
                    ]
                }
                # Vertical range
                $max_hist_data->{left} .. $max_hist_data->{right}
            )
        ]
    );

}



################################################################################
# Find the maximum rectangular area under a histogram
# Takes one argument:
# * A ref to an array of numerical values that constitutes the histogram
# Returns:
# * A a ref to a hash containing the following values:
#   area: The area of the largest rectangle under the histogram
#   height: The height of the rectangle
#   left: The index of the left end of the rectangle
#   right: The index of the right end of the rectangle
# Adapted from the method seen here:
# https://www.youtube.com/watch?v=vcv3REtIvEo
################################################################################
sub find_max_rectangle_under_histogram{
    my $histogram = shift();

    my $i;
    my @stack = ();
    my @right_limits;
    my @left_limits;
    my $max_area;
    my $max_area_index;

    # Scan to the right, looking for
    # left limits
    for $i (0 .. $#$histogram){
        if(scalar(@stack)){
            # Index stack is not empty...
            # Pop the index stack until the top value
            # is less than the current histogram
            # value
            while(
                scalar(@stack)
                &&
                ($histogram->[$i] <= $histogram->[$stack[$#stack]])
            ){
                pop(@stack);
            }
            if(scalar(@stack)){
                $left_limits[$i] = $stack[$#stack] + 1;
            } else{
                # Stack is empty
                $left_limits[$i] = 0;
            }                
            push(@stack, $i);
        } else{
            # Index stack is empty
            $left_limits[$i] = 0;
            push(@stack, $i);
        }
    }

    # Clear the stack
    @stack = ();

    # Scan to the left, looking for
    # right limits
    $i = scalar(@{$histogram});
    while($i--){
        if(scalar(@stack)){
            # Index stack is not empty...
            # Pop the index stack until the top value
            # is less than the current histogram
            # value
            while(
                scalar(@stack)
                &&
                ($histogram->[$i] <= $histogram->[$stack[$#stack]])
            ){
                pop(@stack);
            }
            if(scalar(@stack)){
                $right_limits[$i] = $stack[$#stack] - 1;
            } else{
                # Stack is empty
                $right_limits[$i] = $#$histogram;
            }                
            push(@stack, $i);
        } else{
            # Index stack is empty
            $right_limits[$i] = $#$histogram;
            push(@stack, $i);
        }
    }

    # Calculate areas and find the
    # maximum
    $max_area = 0;
    $max_area_index = 0;
    for $i (0 .. $#$histogram){
        my $area;

        # Calculate the area of the rectangle which
        # completely utilizes the height of this
        # 'bar' in the histogram
        $area =
            $histogram->[$i]
            *
            ($right_limits[$i] - $left_limits[$i] + 1);

        if($area > $max_area){
            # This area is the biggest yet;
            # take note of its size and
            # location
            $max_area = $area;
            $max_area_index = $i;
        }
    }

    return(
        {
            area => $max_area,
            height => $histogram->[$max_area_index],
            left => $left_limits[$max_area_index],
            right => $right_limits[$max_area_index]
        }
    );

}



################################################################################
# Print the contents of a matrix to STDOUT
# Takes two arguments:
# * A ref to an array of arrays whose contents are to be printed to STDOUT,
#   e.g.:
#   [
#       [ 1, 2, 3, 4 ],
#       [ 5, 6, 7, 8 ]
#   ] 
# * An optional string to prepend to each line of the output written to STDOUT,
#   which can be used to establish an indent if desired
# Returns no meaningful value
################################################################################
sub print_matrix{
    my $matrix = shift();
    my $indent = shift();

    $indent = "" unless(defined($indent));

    foreach(@{$matrix}){
        printf("%s[ %s ]\n", $indent, join(" ", @{$_}));
    }

}



