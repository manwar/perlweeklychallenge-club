
use Test;

# Print a Matrix (A 2D array)
multi sub print-matrix(@M){
    say "Problem:";
    @M.map({
        say $_.join(" ");
    });
    say "";
}

# Print a solution matrix given dimensions.
multi sub print-matrix(@dim, $value){
    if !@dim.elems {
        say "0\n";
        return;
    }

    for 0..^@dim[0] {
        say ($value ~ " ") x @dim[1];
    }
    say "";
}

# Splits an array of numbers into segments of contiguous numbers.
# [1, 2, 3, 7,8]  ->   [[1, 2, 3], [7,8]]

sub split-by-contiguous(@A){
    return @A if ! @A.elems;

    reduce sub (@acc, $n){
        if !@acc.elems {
            @acc = [[$n],];
        } elsif @acc[*-1][*-1] == $n-1 {
            @acc[*-1].push($n);
        } else {
            @acc.push([$n]);
        }
        @acc;
    }, [], | @A;
}


# Solution algorithm in a nutshell:
# Given a matrix of 0/1s, first we find another 2D array of the column indexes that are 1's
# Find intersections of these row oombinations of Rows that we need to produce a rectangle.
# Take the largest of the matches and print the solution.

# Solution Example
# Given the matrix
#
#        [[ 0, 0, 0, 1, 1, 1 ],
#         [ 1, 1, 1, 1, 1, 1 ],
#         [ 0, 0, 1, 0, 0, 1 ],
#         [ 0, 0, 1, 1, 1, 1 ],
#         [ 0, 0, 1, 1, 1, 1 ]];

# Find the Column indexes of all the 1's. We also ignore orphan '1's (they can not be part of any rectangle)
# This new array indicates where in the columns are the 1's located in each row.
#  [[3 4 5]
#   [0 1 2 3 4 5]
#   []
#   [2 3 4 5]
#   [2 3 4 5]]


# now get a list of all the row combinations that can form rectangles.
# In this case it would be:
# [(0 1) (0 1 2) (0 1 2 3) (0 1 2 3 4) (1 2) (1 2 3) (1 2 3 4) (2 3) (2 3 4) (3 4)]
# This means we will find the intersection of the Coumn Index array's rows in the above list.
# If we find intersection results, the largest one will be the solution dimension.

sub solve(@M){

    my $num-rows = @M.elems;
    my $num-cols = @M[0].elems;

    # Build the Array that holds the column indexes of 1's in each row.
    my @indices-of-ones = [];
    for 0..^$num-rows -> $i {
        @indices-of-ones.push([]);
        for 0..^$num-cols -> $j {
            if @M[$i][$j] == 1 && (($j > 0 && @M[$i][$j-1] == 1) || ($j < $num-rows-1 && @M[$i][$j+1] == 1)) {
                @indices-of-ones[$i].push($j);
            }
        }
    }

    # Build the row combinations that can form a rectangle.
    my @row-combinations = gather {
        for 0..^$num-rows -> $i {
            for 1..^$num-rows-$i -> $j {
                take ($i..^$num-rows)[0..$j];
            }
        }
    }

    # for all row combinations find the intersection of elements.
    # Keep the dimensions of the results in the accumulator.
    my @results-array = reduce sub (@result, @rows-to-check) {
        # If there are >1 contiguous segments in a row
        # We need to check this for each of those segments.
        my @top-row-segments = split-by-contiguous(@indices-of-ones[@rows-to-check[0]]);
        for @top-row-segments -> @contiguous-index {
             my @common = reduce sub (@acc, $row){
                    @acc = (@acc ∩ @indices-of-ones[$row]).flat;
                    @acc;
             }, @contiguous-index, |@rows-to-check[1..*-1];

             @result.push((@rows-to-check.elems, @common.elems));
        }
        @result;

    }, [], |@row-combinations;

    # sort the dimensions by the number of elements (num rows * num colums) and choose the largest.
    #
    my @largest-array-size =  @results-array.elems > 1 ??  (@results-array.sort: {$^a[0]*$^a[1] cmp  $^b[0]*$^b[1]})[*-1].flat
                                                       !! [];
    say "Solution :";
    print-matrix(@largest-array-size, 1);
}

sub MAIN(){
    my @M = [
        [ 0, 0, 0, 1, 1, 1 ],
        [ 1, 1, 1, 1, 1, 1 ],
        [ 0, 0, 1, 0, 0, 1 ],
        [ 0, 0, 1, 1, 1, 1 ],
        [ 0, 0, 1, 1, 1, 1 ]];
    print-matrix(@M);
    solve(@M);

    my @M1 = [
        [ 1, 0, 1, 0, 1, 0 ],
        [ 0, 1, 0, 1, 0, 1 ],
        [ 1, 0, 1, 0, 1, 0 ],
        [ 0, 1, 0, 1, 0, 1 ]];
    print-matrix(@M1);
    solve(@M1);

    my @M2 = [
        [ 0, 0, 0, 1, 0, 0 ],
        [ 1, 1, 1, 0, 0, 0 ],
        [ 0, 0, 1, 0, 0, 1 ],
        [ 1, 1, 1, 1, 1, 0 ],
        [ 1, 1, 1, 1, 1, 0 ]];
    print-matrix(@M2);
    solve (@M2);
}
