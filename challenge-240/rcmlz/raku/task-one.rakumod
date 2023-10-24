unit module rcmlz::raku::task-one:ver<0.0.1>:auth<github:rcmlz>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr240/rcmlz/raku/ -- test/challenge-nr240/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr240 -- test/benchmark-scalability.raku --task=task-one --user=rcmlz --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr240; cat /tmp/nr240_task-one.csv

#|[
You are given an array of strings and a check string.

- Write a script to find out if the check string is the acronym of the words in the given array.
]
our sub solution((Str $acr, List:D[Str:D] $str) --> Bool) is export {
	$acr.lc eq $str.map( *.substr(0,1) ).join.lc;
}