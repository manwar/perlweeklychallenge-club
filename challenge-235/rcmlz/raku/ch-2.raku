unit module rcmlz::raku::task-two:ver<0.0.1>:auth<rcmlz@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr235/rcmlz/raku/ -- test/challenge-nr235/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr235 -- test/benchmark-scalabiity.raku --task=task-two --user=rcmlz --max-run-times=1,3,7 --test-before-benchmark=True --out-folder=/tmp nr235; cat /tmp/nr235_task-two.csv

#|[
You are given an array of integers.

Write a script to duplicate each occurrence of ZERO in the given array 
and shift the remaining to the right but make sure the size of array remain the same.
]
our sub solution(@input) is export {
    my $n = @input.elems;
    my @output;
    for @input -> $entry {
        if $entry == 0 {
            for ^(min($n, 2)) {
                @output.push: 0;
                $n--; 
            }
        }else{
            @output.push: $entry;            
            $n--; 
        }
        last if $n < 1;
    }
    return @output.List
}