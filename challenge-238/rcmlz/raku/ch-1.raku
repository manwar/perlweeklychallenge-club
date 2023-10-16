unit module rcmlz::raku::task-one:ver<0.0.1>:auth<github:rcmlz>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr238/rcmlz/raku/ -- test/challenge-nr238/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr238 -- test/benchmark-scalabiity.raku --task=task-one --user=rcmlz --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr238; cat /tmp/nr238_task-one.csv

#|[
You are given an array of integers.

- Write a script to return the running sum of the given array.

The running sum can be calculated as sum[i] = num[0] + num[1] + ... + num[i].
]
our sub solution( @input ) is export {
	[\+] @input
}