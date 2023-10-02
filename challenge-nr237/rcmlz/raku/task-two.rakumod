unit module rcmlz::raku::task-two:ver<0.0.1>:auth<github:rcmlz>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr237/rcmlz/raku/ -- test/challenge-nr237/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr237 -- test/benchmark-scalabiity.raku --task=task-two --user=rcmlz --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr237; cat /tmp/nr237_task-two.csv

#|[
You are given an array of integers.

- Write a script to permute the given array such that you get the maximum possible greatness.
- To determine greatness: nums[i] < perm[i] where 0 <= i < nums.length
]
our sub solution(@input) is export {
    my @sorted = @input.sort;
    [+] (@sorted.reverse Z- @sorted).grep(* > 0)
}