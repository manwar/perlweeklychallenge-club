# Wave Array
#
# Any array N of non-unique, unsorted integers can be arranged into a wave-like
# array such that n1 ≥ n2 ≤ n3 ≥ n4 ≤ n5 and so on.
#
# For example, given the array [1, 2, 3, 4], possible wave arrays include [2,
# 1, 4, 3] or [4, 1, 3, 2], since 2 ≥ 1 ≤ 4 ≥ 3 and 4 ≥ 1 ≤ 3 ≥ 2. This is not
# a complete list.
#
# Write a script to print all possible wave arrays for an integer array N of
# arbitrary length.
#
# Notes:
#
# When considering N of any length, note that the first element is always
# greater than or equal to the second, and then the ≤, ≥, ≤, … sequence
# alternates until the end of the array.


# The difficulty is that we have to find all wave arrays. If we only had to
# give one wave function you could easily sort the array and flip some
# neighbours.
# I created a recurrent subroutine that takes two elements from the the array,
# sorts them descending, and computes all wave arrays of the remaining elements
# in the array. Combining the two elements with the wave (sub)arrays, when the
# second element is smaller than the first element in the wave (sub)array,
# gives all wave arrays. I'm curious to find out if there are better ways.

sub wave-sort(@a) {
    if (@a.elems == 0) {
        return [[],];
    } elsif (@a.elems == 1) {
        return [[@a.head],];
    }

    my @ret = [];

    @a = @a.sort.reverse;
    for 0..^@a.elems -> $i {
        for ($i+1)..^@a.elems -> $j {
            my $cur1 = @a[$i];
            my $cur2 = @a[$j];
            my @rest = [|(@a[0..^$i]), |(@a[($i+1)..^$j]), |(@a[($j+1)..*-1])];
            if (@rest.elems > 0) {
                for wave-sort(@rest) -> @r {
                    if ($cur2 <= @r.head) {
                        @ret.push([$cur1, $cur2, |(@r)]);
                    }
                }
            } else {
                @ret.push([$cur1, $cur2]);
            }
        }
    }
    return @ret;
}

say wave-sort([1]);
say wave-sort([1, 2]);
say wave-sort([1, 2, 3]);
say wave-sort([1, 2, 3, 4]);
say wave-sort([1, 2, 3, 4, 5]);
