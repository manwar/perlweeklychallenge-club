unit module rcmlz::raku::task-one:ver<0.0.1>:auth<github:rcmlz>:api<1>;

# run in terminal: raku --optimize=3 -I challenge-nr241/rcmlz/raku/ -- test/challenge-nr241/raku/task-one.rakutest
# or               raku --optimize=3 -I challenge-nr241 -- test/benchmark-scalability.raku --task=task-one --user=rcmlz --max-run-times=1,3,7 --max-problem=10 --v=True --test-before-benchmark=True --out-folder=/tmp nr241; cat /tmp/nr241_task-one.csv

#|[
You are given an array (3 or more members) of integers in increasing order and a positive integer.

Write a script to find out the number of unique Arithmetic Triplets satisfying the following rules:

a) i < j < k
b) nums[j] - nums[i] == diff
c) nums[k] - nums[j] == diff
]
our sub solution([$diff, *@input]) is export {
	my UInt $counter = 0;
	my UInt \n = @input.elems;

	for ^n -> \i {
	  for i+1..^n -> \j {
		if @input[j] - @input[i] == $diff {
	  		for j+1..^n -> \k {
    			$counter++ if @input[k] - @input[j] == $diff
	  		}
		}
	  }
    }
    $counter
}