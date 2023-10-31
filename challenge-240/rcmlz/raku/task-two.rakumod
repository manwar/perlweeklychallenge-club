unit module rcmlz::raku::task-two:ver<0.0.1>:auth<github:rcmlz>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr240/rcmlz/raku/ -- test/challenge-nr240/raku/task-two.rakutest
# or               raku --optimize=3 -I challenge-nr240 -- test/benchmark-scalability.raku --task=task-two --user=rcmlz --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr240; cat /tmp/nr240_task-two.csv

#|[
You are given an array of integers.

- Write a script to create an array such that new[i] = old[old[i]] where 0 <= i < new.length.
]
our sub solution(@input) is export {
    @input[@input]
}