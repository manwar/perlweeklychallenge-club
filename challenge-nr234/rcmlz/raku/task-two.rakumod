unit module rcmlz::raku::task-two:ver<0.0.1>:auth<rcmlz@github.com)>;

# run in terminal: raku --optimize=3 -I challenge-nr234/rcmlz/raku/ -- test/challenge-nr234/raku/task-two.rakutest
#                  raku --optimize=3 -I challenge-nr234 -- test/benchmark-scalabiity.raku --task=task-two --user=rcmlz --max-run-times=1,5,7 --test-before-benchmark=True --out-folder=/tmp nr234; cat /tmp/nr234_task-two.csv

#|[
You are given an array of positive integers.

- Write a script to find the number of triplets (i, j, k) that satisfies 
- num[i] != num[j], num[j] != num[k] and num[k] != num[i].
]
our sub solution(@input) is export {
    @input.Bag.combinations(3).map( *.map( *.value ).reduce(&infix:<*>)).sum
}
