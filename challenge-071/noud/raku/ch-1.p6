# You are given positive integer $N (>1).
#
# Write a script to create an array of size $N with random unique elements
# between 1 and 50.
#
# In the end it should print peak elements in the array, if found.
#
#     An array element is called peak if it is bigger than it’s neighbour.
#
# Example 1
# Array: [ 18, 45, 38, 25, 10, 7, 21, 6, 28, 48 ]
# Peak: [ 48, 45, 21 ]
# Example 2
# Array: [ 47, 11, 32, 8, 1, 9, 39, 14, 36, 23 ]
# Peak: [ 47, 32, 39, 36 ]

sub random_array($N) {
    return (1..50).pick(1..$N);
}

sub get_peaks(@a) {
    if (@a.elems == 1) {
        return @a;
    }
    return [
        |([@a[0] if @a[0] > @a[1]]),
        |([@a[$_] if ((@a[$_] > @a[$_ + 1]) and (@a[$_] > @a[$_ - 1])) for 1..(@a.elems - 2)]),
        |([@a[*-1] if @a[*-1] > @a[*-2]])
    ];
}

my @a = random_array(10);
my @peaks = get_peaks(@a);

@a.say;
@peaks.say;
