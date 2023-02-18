## Task 1: Monotonic Array

Given an array of integers, the script is supposed to find out if the given
array is Monotonic, and print 1 if it is, and 0 otherwise.

My solution uses List::Util's `reduce` function, once to check for
monotone increasing and once for monotone decreasing.

In `reduce`, the code block is executed first for the first two elements of the
parameter list, then for its result and the third element, and so on for all
elements.
The idea is to pass on a kind of _status_ to the next code block execution
to indicate whether so far, all numbers have been monotone increasing
(or decreasing in the other call) or whether there was a mismatch.
That's easy -- we pass `undef` as a result once the chain is broken,
and once we have an `undef` we keep it until the end.
If all is still good, we pass the current value for comparison
with the next element in the next round.

This looks like this:

```perl
sub monotonic {
    return 1
        if reduce { ( defined $a && $a <= $b ) ? $b : undef } @_
        or reduce { ( defined $a && $a >= $b ) ? $b : undef } @_;
    return 0;
}
```

I know that we waste some runtime by walking through all elements even once
we have found a mismatch, but I really like the conciseness of this solution
(it might be just for me personally, but I find it 'elegant').

## Task 2: Reshape matrix

Given a matrix ( _m_ x _n_ ) and two integers (_r_ and _c_), the script shall
reshape the given matrix in form ( _r_ x _c_ ) with the original values of the
given matrix. If it can’t reshape it shall print 0.

My approach is to create one linear array that contains all the elements of the
original matrix. Then assign the first _c_ elements to a new row of the
resulting matrix, while deleting them from the linear array.
The `slice`function offers itself
perfectly for doing ths in one step.
Repeat until the linear array is used up.

This will result in a nice matrix only when we have exactly _r_ x _c_ elements,
so we check this condition first.

Using _signatures_, this function does the job:

```perl
sub reshape( $matrix, $r, $c ) {
    my @all_elements = map @$_, @$matrix;
    return undef
        unless @all_elements == $r * $c;
    my $reshaped = [];
    push @$reshaped, [ splice @all_elements, 0, $c, () ]
        while @all_elements;
    return $reshaped;
}
```

Note that the function returns `undef` on failure. It is left up to the
caller to transform this into `0` for output.
I found this a better style, keeping the implementation part more
'Perl'ish and also making it easier to interpret the result for the caller.
Good to have everything output-related in just one place then.

I have put a description of the examples into the script's _\_\_DATA\_\__
section in a nice, readable form, together with their expected output.
The rest of the script reads the examples, runs one loop for
the example output and then another for running the test cases using
_Test::More_.  
Perl has been my favorite language for doing this type of
'free-text-to-data-structures' transformation for a long time.

It was fun to take part in the challenge!
