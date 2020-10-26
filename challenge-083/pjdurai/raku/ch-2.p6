#!/usr/bin/env raku


# Brute force solution.

# Generate all possible combinations of the indexes into the array.
# For each combination, set those elements to their negative.
# Sum up the array elements
# If the sum is smaller than the previous sum, remember the sum and the number of nagatives.

sub solve (@A){
    my @result-pair = reduce sub (@acc, @indexes) {
        if @indexes.elems {
            # set the indexes to nagative of those values
            for @indexes -> $index {
                @A[$index] = -(@A[$index]);
            }

            # sum up the array
            my $val = [+] @A;
            
            # if the value is less than the previous attempt,
            # remember the value and num of nagative elements
            if $val >= 0 && $val < @acc[0] {
                @acc[0] = $val;
                @acc[1] = (@A.grep:{$_ < 0}).elems;
            }
            # clear the negatives
            @A = map &abs, @A;
        }
        @acc;
    }, [Inf,0], |(0..@A.elems-1).combinations;

    @result-pair[1];
}

sub MAIN(){
    say solve([3, 10, 8]);
    say solve([2, 10, 12]);
}
