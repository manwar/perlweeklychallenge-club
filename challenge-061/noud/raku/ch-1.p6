# Given a list of 4 or more numbers, write a script to find the contiguous
# sublist that has the maximum product. The length of the sublist is
# irrelevant; your job is to maximize the product.
#
# Example
#
# Input: [ 2, 5, -1, 3 ]
#
# Output: [ 2, 5 ] which gives maximum product 10.

sub max-conseq-prod(@a) {
    gather for ^@a.elems -> $i {
        for $i+1..^@a.elems -> $j {
            take @a[$i..$j];
        }
    }.sort({ .reduce(&[*]) })[*-1];
}

max-conseq-prod([2, 5, -1, 3]).say;
